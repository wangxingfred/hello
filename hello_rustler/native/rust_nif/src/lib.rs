mod scene;
mod obj;
mod battle;
mod tb;
mod team;
mod record;

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

#[rustler::nif]
fn ft() {
    scene::create();
}

rustler::init!("Elixir.RustNif", [add, hashmap, ft]);
