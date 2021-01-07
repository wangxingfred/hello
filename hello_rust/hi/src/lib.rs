use std::collections::HashMap;

pub fn hi() {
    println!("hi");
}

pub fn hashmap(mut count: u64) {
    let mut map = HashMap::new();

    while count > 0 {
        map.insert(count, count);
        count = count - 1;
    }
}