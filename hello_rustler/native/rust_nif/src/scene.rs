use std::collections::HashMap;

#[derive(Debug)]
pub struct Scene {
    dic: HashMap<i64, i64>
}

impl Scene {
    pub fn put(&mut self, key: i64, value: i64) {
        self.dic.insert(key, value);
    }
}


pub fn create() {
    let mut scene = Scene {
        dic: HashMap::with_capacity(200)
    };
}