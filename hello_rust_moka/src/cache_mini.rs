use mini_moka::unsync::Cache;


#[cfg(test)]
mod tests {
    use mini_moka::unsync::Cache;
    // use crate::common::time::Clock;

    use std::time::Duration;

    #[test]
    fn basic_single_thread() {
        let mut cache = Cache::new(3);
        // cache.enable_frequency_sketch_for_testing();

        cache.insert("a", "alice");
        cache.insert("b", "bob");
        assert_eq!(cache.get(&"a"), Some(&"alice"));
        assert!(cache.contains_key(&"a"));
        assert!(cache.contains_key(&"b"));
        assert_eq!(cache.get(&"b"), Some(&"bob"));
        // counts: a -> 1, b -> 1

        cache.insert("c", "cindy");
        assert_eq!(cache.get(&"c"), Some(&"cindy"));
        assert!(cache.contains_key(&"c"));
        // counts: a -> 1, b -> 1, c -> 1

        assert!(cache.contains_key(&"a"));
        assert_eq!(cache.get(&"a"), Some(&"alice"));
        assert_eq!(cache.get(&"b"), Some(&"bob"));
        assert!(cache.contains_key(&"b"));
        // counts: a -> 2, b -> 2, c -> 1

        // "d" should not be admitted because its frequency is too low.
        cache.insert("d", "david"); //   count: d -> 0
        assert_eq!(cache.get(&"d"), None); //   d -> 1
        assert!(!cache.contains_key(&"d"));

        cache.insert("d", "david");
        assert!(!cache.contains_key(&"d"));
        assert_eq!(cache.get(&"d"), None); //   d -> 2

        // "d" should be admitted and "c" should be evicted
        // because d's frequency is higher than c's.
        cache.insert("d", "dennis");
        assert_eq!(cache.get(&"a"), Some(&"alice"));
        assert_eq!(cache.get(&"b"), Some(&"bob"));
        assert_eq!(cache.get(&"c"), None);
        assert_eq!(cache.get(&"d"), Some(&"dennis"));
        assert!(cache.contains_key(&"a"));
        assert!(cache.contains_key(&"b"));
        assert!(!cache.contains_key(&"c"));
        assert!(cache.contains_key(&"d"));

        cache.invalidate(&"b");
        assert_eq!(cache.get(&"b"), None);
        assert!(!cache.contains_key(&"b"));
    }
    //
    // #[test]
    // fn size_aware_eviction() {
    //     let weigher = |_k: &&str, v: &(&str, u32)| v.1;
    //
    //     let alice = ("alice", 10);
    //     let bob = ("bob", 15);
    //     let bill = ("bill", 20);
    //     let cindy = ("cindy", 5);
    //     let david = ("david", 15);
    //     let dennis = ("dennis", 15);
    //
    //     let mut cache = Cache::builder().max_capacity(31).weigher(weigher).build();
    //     cache.enable_frequency_sketch_for_testing();
    //
    //     cache.insert("a", alice);
    //     cache.insert("b", bob);
    //     assert_eq!(cache.get(&"a"), Some(&alice));
    //     assert!(cache.contains_key(&"a"));
    //     assert!(cache.contains_key(&"b"));
    //     assert_eq!(cache.get(&"b"), Some(&bob));
    //     // order (LRU -> MRU) and counts: a -> 1, b -> 1
    //
    //     cache.insert("c", cindy);
    //     assert_eq!(cache.get(&"c"), Some(&cindy));
    //     assert!(cache.contains_key(&"c"));
    //     // order and counts: a -> 1, b -> 1, c -> 1
    //
    //     assert!(cache.contains_key(&"a"));
    //     assert_eq!(cache.get(&"a"), Some(&alice));
    //     assert_eq!(cache.get(&"b"), Some(&bob));
    //     assert!(cache.contains_key(&"b"));
    //     // order and counts: c -> 1, a -> 2, b -> 2
    //
    //     // To enter "d" (weight: 15), it needs to evict "c" (w: 5) and "a" (w: 10).
    //     // "d" must have higher count than 3, which is the aggregated count
    //     // of "a" and "c".
    //     cache.insert("d", david); //   count: d -> 0
    //     assert_eq!(cache.get(&"d"), None); //   d -> 1
    //     assert!(!cache.contains_key(&"d"));
    //
    //     cache.insert("d", david);
    //     assert!(!cache.contains_key(&"d"));
    //     assert_eq!(cache.get(&"d"), None); //   d -> 2
    //
    //     cache.insert("d", david);
    //     assert_eq!(cache.get(&"d"), None); //   d -> 3
    //     assert!(!cache.contains_key(&"d"));
    //
    //     cache.insert("d", david);
    //     assert!(!cache.contains_key(&"d"));
    //     assert_eq!(cache.get(&"d"), None); //   d -> 4
    //
    //     // Finally "d" should be admitted by evicting "c" and "a".
    //     cache.insert("d", dennis);
    //     assert_eq!(cache.get(&"a"), None);
    //     assert_eq!(cache.get(&"b"), Some(&bob));
    //     assert_eq!(cache.get(&"c"), None);
    //     assert_eq!(cache.get(&"d"), Some(&dennis));
    //     assert!(!cache.contains_key(&"a"));
    //     assert!(cache.contains_key(&"b"));
    //     assert!(!cache.contains_key(&"c"));
    //     assert!(cache.contains_key(&"d"));
    //
    //     // Update "b" with "bill" (w: 15 -> 20). This should evict "d" (w: 15).
    //     cache.insert("b", bill);
    //     assert_eq!(cache.get(&"b"), Some(&bill));
    //     assert_eq!(cache.get(&"d"), None);
    //     assert!(cache.contains_key(&"b"));
    //     assert!(!cache.contains_key(&"d"));
    //
    //     // Re-add "a" (w: 10) and update "b" with "bob" (w: 20 -> 15).
    //     cache.insert("a", alice);
    //     cache.insert("b", bob);
    //     assert_eq!(cache.get(&"a"), Some(&alice));
    //     assert_eq!(cache.get(&"b"), Some(&bob));
    //     assert_eq!(cache.get(&"d"), None);
    //     assert!(cache.contains_key(&"a"));
    //     assert!(cache.contains_key(&"b"));
    //     assert!(!cache.contains_key(&"d"));
    //
    //     // Verify the sizes.
    //     assert_eq!(cache.entry_count(), 2);
    //     assert_eq!(cache.weighted_size(), 25);
    // }
    //
    // #[test]
    // fn invalidate_all() {
    //     let mut cache = Cache::new(100);
    //     cache.enable_frequency_sketch_for_testing();
    //
    //     cache.insert("a", "alice");
    //     cache.insert("b", "bob");
    //     cache.insert("c", "cindy");
    //     assert_eq!(cache.get(&"a"), Some(&"alice"));
    //     assert_eq!(cache.get(&"b"), Some(&"bob"));
    //     assert_eq!(cache.get(&"c"), Some(&"cindy"));
    //     assert!(cache.contains_key(&"a"));
    //     assert!(cache.contains_key(&"b"));
    //     assert!(cache.contains_key(&"c"));
    //
    //     cache.invalidate_all();
    //
    //     cache.insert("d", "david");
    //
    //     assert!(cache.get(&"a").is_none());
    //     assert!(cache.get(&"b").is_none());
    //     assert!(cache.get(&"c").is_none());
    //     assert_eq!(cache.get(&"d"), Some(&"david"));
    //     assert!(!cache.contains_key(&"a"));
    //     assert!(!cache.contains_key(&"b"));
    //     assert!(!cache.contains_key(&"c"));
    //     assert!(cache.contains_key(&"d"));
    // }
    //
    // #[test]
    // fn invalidate_entries_if() {
    //     use std::collections::HashSet;
    //
    //     let mut cache = Cache::new(100);
    //     cache.enable_frequency_sketch_for_testing();
    //
    //     let (clock, mock) = Clock::mock();
    //     cache.set_expiration_clock(Some(clock));
    //
    //     cache.insert(0, "alice");
    //     cache.insert(1, "bob");
    //     cache.insert(2, "alex");
    //
    //     mock.increment(Duration::from_secs(5)); // 5 secs from the start.
    //
    //     assert_eq!(cache.get(&0), Some(&"alice"));
    //     assert_eq!(cache.get(&1), Some(&"bob"));
    //     assert_eq!(cache.get(&2), Some(&"alex"));
    //     assert!(cache.contains_key(&0));
    //     assert!(cache.contains_key(&1));
    //     assert!(cache.contains_key(&2));
    //
    //     let names = ["alice", "alex"].iter().cloned().collect::<HashSet<_>>();
    //     cache.invalidate_entries_if(move |_k, &v| names.contains(v));
    //
    //     mock.increment(Duration::from_secs(5)); // 10 secs from the start.
    //
    //     cache.insert(3, "alice");
    //
    //     assert!(cache.get(&0).is_none());
    //     assert!(cache.get(&2).is_none());
    //     assert_eq!(cache.get(&1), Some(&"bob"));
    //     // This should survive as it was inserted after calling invalidate_entries_if.
    //     assert_eq!(cache.get(&3), Some(&"alice"));
    //
    //     assert!(!cache.contains_key(&0));
    //     assert!(cache.contains_key(&1));
    //     assert!(!cache.contains_key(&2));
    //     assert!(cache.contains_key(&3));
    //
    //     assert_eq!(cache.cache.len(), 2);
    //
    //     mock.increment(Duration::from_secs(5)); // 15 secs from the start.
    //
    //     cache.invalidate_entries_if(|_k, &v| v == "alice");
    //     cache.invalidate_entries_if(|_k, &v| v == "bob");
    //
    //     assert!(cache.get(&1).is_none());
    //     assert!(cache.get(&3).is_none());
    //
    //     assert!(!cache.contains_key(&1));
    //     assert!(!cache.contains_key(&3));
    //
    //     assert_eq!(cache.cache.len(), 0);
    // }
    //
    // #[test]
    // fn time_to_live() {
    //     let mut cache = Cache::builder()
    //         .max_capacity(100)
    //         .time_to_live(Duration::from_secs(10))
    //         .build();
    //     cache.enable_frequency_sketch_for_testing();
    //
    //     let (clock, mock) = Clock::mock();
    //     cache.set_expiration_clock(Some(clock));
    //
    //     cache.insert("a", "alice");
    //
    //     mock.increment(Duration::from_secs(5)); // 5 secs from the start.
    //
    //     assert_eq!(cache.get(&"a"), Some(&"alice"));
    //     assert!(cache.contains_key(&"a"));
    //
    //     mock.increment(Duration::from_secs(5)); // 10 secs.
    //
    //     assert_eq!(cache.get(&"a"), None);
    //     assert!(!cache.contains_key(&"a"));
    //     assert_eq!(cache.iter().count(), 0);
    //     assert!(cache.cache.is_empty());
    //
    //     cache.insert("b", "bob");
    //
    //     assert_eq!(cache.cache.len(), 1);
    //
    //     mock.increment(Duration::from_secs(5)); // 15 secs.
    //
    //     assert_eq!(cache.get(&"b"), Some(&"bob"));
    //     assert!(cache.contains_key(&"b"));
    //     assert_eq!(cache.cache.len(), 1);
    //
    //     cache.insert("b", "bill");
    //
    //     mock.increment(Duration::from_secs(5)); // 20 secs
    //
    //     assert_eq!(cache.get(&"b"), Some(&"bill"));
    //     assert!(cache.contains_key(&"b"));
    //     assert_eq!(cache.cache.len(), 1);
    //
    //     mock.increment(Duration::from_secs(5)); // 25 secs
    //
    //     assert_eq!(cache.get(&"a"), None);
    //     assert_eq!(cache.get(&"b"), None);
    //     assert!(!cache.contains_key(&"a"));
    //     assert!(!cache.contains_key(&"b"));
    //     assert_eq!(cache.iter().count(), 0);
    //     assert!(cache.cache.is_empty());
    // }
    //
    // #[test]
    // fn time_to_idle() {
    //     let mut cache = Cache::builder()
    //         .max_capacity(100)
    //         .time_to_idle(Duration::from_secs(10))
    //         .build();
    //     cache.enable_frequency_sketch_for_testing();
    //
    //     let (clock, mock) = Clock::mock();
    //     cache.set_expiration_clock(Some(clock));
    //
    //     cache.insert("a", "alice");
    //
    //     mock.increment(Duration::from_secs(5)); // 5 secs from the start.
    //
    //     assert_eq!(cache.get(&"a"), Some(&"alice"));
    //
    //     mock.increment(Duration::from_secs(5)); // 10 secs.
    //
    //     cache.insert("b", "bob");
    //
    //     assert_eq!(cache.cache.len(), 2);
    //
    //     mock.increment(Duration::from_secs(2)); // 12 secs.
    //
    //     // contains_key does not reset the idle timer for the key.
    //     assert!(cache.contains_key(&"a"));
    //     assert!(cache.contains_key(&"b"));
    //
    //     assert_eq!(cache.cache.len(), 2);
    //
    //     mock.increment(Duration::from_secs(3)); // 15 secs.
    //
    //     assert_eq!(cache.get(&"a"), None);
    //     assert_eq!(cache.get(&"b"), Some(&"bob"));
    //     assert!(!cache.contains_key(&"a"));
    //     assert!(cache.contains_key(&"b"));
    //     assert_eq!(cache.iter().count(), 1);
    //     assert_eq!(cache.cache.len(), 1);
    //
    //     mock.increment(Duration::from_secs(10)); // 25 secs
    //
    //     assert_eq!(cache.get(&"a"), None);
    //     assert_eq!(cache.get(&"b"), None);
    //     assert!(!cache.contains_key(&"a"));
    //     assert!(!cache.contains_key(&"b"));
    //     assert_eq!(cache.iter().count(), 0);
    //     assert!(cache.cache.is_empty());
    // }
    //
    // #[cfg_attr(target_pointer_width = "16", ignore)]
    // #[test]
    // fn test_skt_capacity_will_not_overflow() {
    //     // power of two
    //     let pot = |exp| 2u64.pow(exp);
    //
    //     let ensure_sketch_len = |max_capacity, len, name| {
    //         let mut cache = Cache::<u8, u8>::new(max_capacity);
    //         cache.enable_frequency_sketch_for_testing();
    //         assert_eq!(cache.frequency_sketch.table_len(), len as usize, "{}", name);
    //     };
    //
    //     if cfg!(target_pointer_width = "32") {
    //         let pot24 = pot(24);
    //         let pot16 = pot(16);
    //         ensure_sketch_len(0, 128, "0");
    //         ensure_sketch_len(128, 128, "128");
    //         ensure_sketch_len(pot16, pot16, "pot16");
    //         // due to ceiling to next_power_of_two
    //         ensure_sketch_len(pot16 + 1, pot(17), "pot16 + 1");
    //         // due to ceiling to next_power_of_two
    //         ensure_sketch_len(pot24 - 1, pot24, "pot24 - 1");
    //         ensure_sketch_len(pot24, pot24, "pot24");
    //         ensure_sketch_len(pot(27), pot24, "pot(27)");
    //         ensure_sketch_len(u32::MAX as u64, pot24, "u32::MAX");
    //     } else {
    //         // target_pointer_width: 64 or larger.
    //         let pot30 = pot(30);
    //         let pot16 = pot(16);
    //         ensure_sketch_len(0, 128, "0");
    //         ensure_sketch_len(128, 128, "128");
    //         ensure_sketch_len(pot16, pot16, "pot16");
    //         // due to ceiling to next_power_of_two
    //         ensure_sketch_len(pot16 + 1, pot(17), "pot16 + 1");
    //
    //         // The following tests will allocate large memory (~8GiB).
    //         // Skip when running on Circle CI.
    //         if !cfg!(circleci) {
    //             // due to ceiling to next_power_of_two
    //             ensure_sketch_len(pot30 - 1, pot30, "pot30- 1");
    //             ensure_sketch_len(pot30, pot30, "pot30");
    //             ensure_sketch_len(u64::MAX, pot30, "u64::MAX");
    //         }
    //     };
    // }
    //
    // #[test]
    // fn test_debug_format() {
    //     let mut cache = Cache::new(10);
    //     cache.insert('a', "alice");
    //     cache.insert('b', "bob");
    //     cache.insert('c', "cindy");
    //
    //     let debug_str = format!("{:?}", cache);
    //     assert!(debug_str.starts_with('{'));
    //     assert!(debug_str.contains(r#"'a': "alice""#));
    //     assert!(debug_str.contains(r#"'b': "bob""#));
    //     assert!(debug_str.contains(r#"'c': "cindy""#));
    //     assert!(debug_str.ends_with('}'));
    // }
}
