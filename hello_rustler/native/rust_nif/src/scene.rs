use std::collections::HashMap;

use super::*;
use crate::obj::ObjMaxId;
use crate::record::Record;

pub const ID_BIT: i32 = 40;
pub const TID_BIT: i32 = 16;
pub const TYPE_BIT: i32 = 8;

pub enum Atom {
    ObjMatchMaxId // OBJ_MATCH_MAX_ID
}

#[derive(Debug)]
pub struct Scene {
    dic: HashMap<i64, i64>,
    atom_dic: HashMap<Atom, i64>,
    rec_dic: HashMap<i64, Box<dyn Record>>
}

impl Scene {
    pub fn put(&mut self, key: i64, value: i64) {
        self.dic.insert(key, value);
        // self.dic[&key] = value;
    }
    pub fn get(&self, key: i64) -> i64 {
        // self.dic.get(&key).unwrap().clone();
        self.dic[&key]
    }

    pub fn atom_put(&mut self, key: Atom, value: i64) {
        self.atom_dic.insert(key, value);
    }
    pub fn atom_get(&mut self, key: Atom) -> i64 {
        self.atom_dic[&key]
    }

    pub fn rec_put(&mut self, key: i64, value: Box<dyn Record>) {
        self.rec_dic.insert(key, value);
    }
    pub fn rec_get(&mut self, key: i64) -> &Box<dyn Record> {
        &self.rec_dic[&key]
    }
}


pub fn create() -> i64 {
    let mut s = Scene {
        dic: HashMap::with_capacity(200),
        atom_dic: HashMap::with_capacity(200),
        rec_dic: HashMap::with_capacity(200)
    };
    obj::create(&mut s, obj::ObjMaxId::Match);
    obj::create(&mut s, obj::ObjMaxId::Fighter);
    obj::create(&mut s, obj::ObjMaxId::Ability);
    obj::create(&mut s, obj::ObjMaxId::Buff);
    obj::create(&mut s, obj::ObjMaxId::Action);
    obj::create(&mut s, obj::ObjMaxId::Effect);
    obj::create(&mut s, obj::ObjMaxId::Event);

    obj::mach::create(&mut s)
}