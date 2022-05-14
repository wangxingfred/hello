use lru::LruCache;

pub fn hi_lru() {
    let mut cache = LruCache::new(5);

    cache.put(1, "a");
    cache.put(2, "b");
    cache.put(3, "c");
    cache.put(4, "d");
    println!("cache.len() = {}", cache.len());

    assert_eq!(cache.pop_lru(), Some((1, "a")));
    assert_eq!(cache.pop_lru(), Some((2, "b")));

    cache.get(&3);
    assert_eq!(cache.pop_lru(), Some((4, "d")));
    assert_eq!(cache.pop_lru(), Some((3, "c")));

    assert_eq!(cache.pop_lru(), None);
    assert_eq!(cache.len(), 0);
}