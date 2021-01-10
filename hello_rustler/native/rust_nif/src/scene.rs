use std::collections::HashMap;
use std::hash::{Hash, Hasher};

use super::*;
use super::tb;

pub const ID_BIT: i32 = 40;
pub const TID_BIT: i32 = 16;
pub const TYPE_BIT: i32 = 8;

#[derive(Copy, Clone, Debug)]
pub enum Atom {
    ObjMatchMaxId,
    ObjFighterMaxId,
    ObjAbilityMaxId,
    ObjBuffMaxId,
    ObjEffectMaxId,
    ObjEventMaxId,
    ObjActionMaxId,
    ObjConfigAll,

    FightMatchId,
}

impl PartialEq for Atom {
    fn eq(&self, other: &Self) -> bool {
        self == other
    }
}

impl Eq for Atom {}

impl Hash for Atom {
    fn hash<H: Hasher>(&self, state: &mut H) {
        let v = *self as i32;
        v.hash(state)
    }
}

pub(crate) enum MapValue {
    Bool(bool),
    Int64(i64),
    Cfg(Box<tb::Cfg>),
    AllFighters(Box<Vec<i64>>)
}

pub(crate) enum AtomMapValue {
    Int64(i64)
}

pub struct Scene {
    // dic: HashMap<i64, i64>,
    atom_dic: HashMap<Atom, AtomMapValue>,
    box_dic: HashMap<i64, MapValue>,
}

impl Scene {
    // pub(crate) fn put_int(&mut self, key: i64, value: i64) {
    //     self.dic.insert(key, value);
    // }
    // pub(crate) fn get_int(&self, key: i64) -> i64 {
    //     self.dic[&key]
    // }

    pub(crate) fn atom_put(&mut self, key: Atom, value: AtomMapValue) {
        self.atom_dic.insert(key, value);
    }
    pub(crate) fn atom_get(&mut self, key: Atom) -> &AtomMapValue {
        &self.atom_dic[&key]
    }

    pub(crate) fn put(&mut self, key: i64, value: MapValue) {
        self.box_dic.insert(key, value);
    }
    pub(crate) fn get(&self, key: i64) -> &MapValue {
        &self.box_dic[&key]
    }
    pub(crate) fn try_get(&self, key: i64) -> Option<&MapValue> {
        self.box_dic.get(&key)
    }
    pub(crate) fn contains(&self, key: i64) -> bool {
        self.box_dic.contains_key(&key)
    }
}


pub fn create() -> i64 {
    let mut s = Scene {
        // dic: HashMap::with_capacity(200),
        atom_dic: HashMap::with_capacity(200),
        box_dic: HashMap::with_capacity(200),
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