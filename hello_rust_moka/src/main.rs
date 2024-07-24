mod cache;
mod cache_mini;

fn main() {
    println!("Hello, world!");
}

#[cfg(test)]
mod tests {
    use crate::cache::CacheKV;

    // #[test]
    // fn max_capacity_zero() {
    //     let mut cache = CacheKV::new(0);
    //
    //     cache.put(0, ());
    // }
}