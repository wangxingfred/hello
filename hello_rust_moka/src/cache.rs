use std::collections::HashSet;
use std::ops::Deref;
use std::sync::{Arc, Mutex};
use std::vec;
use moka::sync::{Cache as MokaCache, Cache};
use moka::notification::RemovalCause;
use moka::policy::EvictionPolicy;


pub struct CacheKV<K, V> {
    moka: MokaCache<K, V>,

    /// 记录某个操作过程中被淘汰的数据
    evicted: Arc<Mutex<Vec<Arc<K>>>>,
}

impl<K: std::fmt::Debug + std::hash::Hash + Eq + Send + Sync + Clone + 'static,
    V: std::fmt::Debug + Clone + Send + Sync + 'static> CacheKV<K, V> {

    pub fn new(cap: u64) -> CacheKV<K, V> {

        let evicted = Arc::new(Mutex::new(Vec::new()));
        let evicted2 = evicted.clone();
        let eviction_listener = move |key, _value, cause| {
            println!("Evicted key {key:#?}. Cause: {cause:#?}. evicted: {evicted2:#?}");

            match cause {
                RemovalCause::Replaced => {}
                _ => if let Ok(mut evicted3) = evicted2.lock() {
                    evicted3.push(key)
                }
            }
        };

        let moka = MokaCache::builder()
            .max_capacity(cap)
            .eviction_policy(EvictionPolicy::lru())
            // .expire_after(expiry)
            .eviction_listener(eviction_listener)
            .build();

        CacheKV { moka, evicted }
    }

    /// 返回因超过容量而被移除的key-value，如果没超过容量则返回None
    pub fn insert(&self, k: K, v: V) -> Option<Vec<K>> {
        self.moka.insert(k, v);
        self.moka.run_pending_tasks();

        // if let Some(evicted) = self.evicted.lock() {
        //     if !evicted.is_empty() {
        //         let cloned = evicted.iter().map(|term| term.deref().clone()).collect::<Vec<_>>();
        //         return Some(cloned);
        //     }
        // }

        return match self.evicted.lock() {
            Ok(evicted) if !evicted.is_empty() => {
                let cloned = evicted.iter().map(|term| term.deref().clone()).collect::<Vec<_>>();
                Some(cloned)
            }
            _ => None
        }
    }
}

#[test]
fn basic_test() {
    let cache = CacheKV::new(3);

    let v1 = cache.insert(1, "111");
    let v2 = cache.insert(2,"222");
    let v3 = cache.insert(3, "333");
    cache.moka.run_pending_tasks();
    // let v1 = cache.moka.iter().map(|(k, _v)| *k).collect::<Vec<_>>();

    let v4 = cache.insert(4, "444");
    cache.moka.run_pending_tasks();
    // let v2 = cache.moka.iter().map(|(k, _v)| *k).collect::<Vec<_>>();

    let v5 = cache.insert(5, "555");
    cache.moka.run_pending_tasks();
    // let v3 = cache.moka.iter().map(|(k, _v)| *k).collect::<Vec<_>>();

    let v6 = cache.insert(4, "444444");
    cache.moka.run_pending_tasks();
    let v4 = cache.moka.iter().map(|(k, _v)| *k).collect::<Vec<_>>();

    // v3.lock().unwrap().iter().for_each(|x| {
    //     println!("{x:#?}")
    // });
    // v2.lock().unwrap().iter().for_each(|x| {
    //     println!("{x:#?}")
    // });
    // v1.lock().unwrap().iter().for_each(|x| {
    //     println!("{x:#?}")
    // });
    // v4.lock().unwrap().iter().for_each(|x| {
    //     println!("{x:#?}")
    // });
    // v5.lock().unwrap().iter().for_each(|x| {
    //     println!("{x:#?}")
    // });
    // v6.lock().unwrap().iter().for_each(|x| {
    //     println!("{x:#?}")
    // });
}

#[test]
fn basic_single_thread() {
    // The following `Vec`s will hold actual and expected notifications.
    let actual = Arc::new(Mutex::new(Vec::new()));
    let mut expected = Vec::new();

    // Create an eviction listener.
    let a1 = Arc::clone(&actual);
    let listener = move |k, v, cause| {
        a1.lock().unwrap().push((k, v, cause))
    };

    // Create a cache with the eviction listener.
    let mut cache = Cache::builder()
        .max_capacity(3)
        .eviction_listener(listener)
        .build();
    // cache.reconfigure_for_testing();

    // Make the cache exterior immutable.
    let cache = cache;

    cache.insert("a", "alice");
    cache.insert("b", "bob");
    assert_eq!(cache.get(&"a"), Some("alice"));
    assert!(cache.contains_key(&"a"));
    assert!(cache.contains_key(&"b"));
    assert_eq!(cache.get(&"b"), Some("bob"));
    cache.run_pending_tasks();
    // counts: a -> 1, b -> 1

    cache.insert("c", "cindy");
    assert_eq!(cache.get(&"c"), Some("cindy"));
    assert!(cache.contains_key(&"c"));
    // counts: a -> 1, b -> 1, c -> 1
    cache.run_pending_tasks();

    assert!(cache.contains_key(&"a"));
    assert_eq!(cache.get(&"a"), Some("alice"));
    assert_eq!(cache.get(&"b"), Some("bob"));
    assert!(cache.contains_key(&"b"));
    cache.run_pending_tasks();
    // counts: a -> 2, b -> 2, c -> 1

    // "d" should not be admitted because its frequency is too low.
    cache.insert("d", "david"); //   count: d -> 0
    expected.push((Arc::new("d"), "david", RemovalCause::Size));
    cache.run_pending_tasks();
    assert_eq!(cache.get(&"d"), None); //   d -> 1
    assert!(!cache.contains_key(&"d"));

    cache.insert("d", "david");
    expected.push((Arc::new("d"), "david", RemovalCause::Size));
    cache.run_pending_tasks();
    assert!(!cache.contains_key(&"d"));
    assert_eq!(cache.get(&"d"), None); //   d -> 2

    // "d" should be admitted and "c" should be evicted
    // because d's frequency is higher than c's.
    cache.insert("d", "dennis");
    expected.push((Arc::new("c"), "cindy", RemovalCause::Size));
    cache.run_pending_tasks();
    assert_eq!(cache.get(&"a"), Some("alice"));
    assert_eq!(cache.get(&"b"), Some("bob"));
    assert_eq!(cache.get(&"c"), None);
    assert_eq!(cache.get(&"d"), Some("dennis"));
    assert!(cache.contains_key(&"a"));
    assert!(cache.contains_key(&"b"));
    assert!(!cache.contains_key(&"c"));
    assert!(cache.contains_key(&"d"));

    cache.invalidate(&"b");
    expected.push((Arc::new("b"), "bob", RemovalCause::Explicit));
    cache.run_pending_tasks();
    assert_eq!(cache.get(&"b"), None);
    assert!(!cache.contains_key(&"b"));

    assert!(cache.remove(&"b").is_none());
    assert_eq!(cache.remove(&"d"), Some("dennis"));
    expected.push((Arc::new("d"), "dennis", RemovalCause::Explicit));
    cache.run_pending_tasks();
    assert_eq!(cache.get(&"d"), None);
    assert!(!cache.contains_key(&"d"));

    // verify_notification_vec(&cache, actual, &expected);
    // assert!(cache.key_locks_map_is_empty());
}