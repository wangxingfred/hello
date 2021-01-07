mod scene;

use std::collections::HashMap;

#[rustler::nif]
fn add(a: i64, b: i64) -> i64 {
    a + b
}

#[rustler::nif]
fn hashmap(count: u64) {
    let mut count = count;
    let mut map = HashMap::with_capacity(count as usize);

    while count > 0 {
        map.insert(count, count);
        count = count - 1;
    }
}

rustler::init!("Elixir.RustNif", [add, hashmap]);
