pub(crate) mod mach;

use super::*;
use super::scene::*;

pub(crate) enum ObjMaxId {
    Match,
    Fighter,
    Ability,
    Buff,
    Effect,
    Event,
    Action,
    Config
}

pub(crate) const OBJ_MATCH: i64 = 1;
pub(crate) const OBJ_FIGHTER: i64 = 2;
pub(crate) const OBJ_ABILITY: i64 = 3;
pub(crate) const OBJ_BUFF: i64 = 4;
pub(crate) const OBJ_EFFECT: i64 = 5;
pub(crate) const OBJ_EVENT: i64 = 6;
pub(crate) const OBJ_ACTION: i64 = 7;

pub(crate) fn create(s: &mut Scene, max_id_key: ObjMaxId) {
    s.put(max_id_key as i64, MapValue::Int64(1))
}

pub(crate) fn new_id(s: &mut Scene, max_id_key: Atom, type_: i64) -> i64 {
    let value = s.atom_get(max_id_key);
    if let MapValue::Int64(max_id) = *value {
        s.atom_put(max_id_key, AtomMapValue::Int64(max_id + 1));
        return (max_id << scene::ID_BIT) | (type_ << scene::TYPE_BIT);
    } else {
        panic!("max_id_key {} not exist", max_id_key)
    }
}

pub(crate) fn new_id2(s: &mut Scene, max_id_key: Atom, type_: i64, tid: i64) -> i64 {
    let value = s.atom_get(max_id_key);
    if let MapValue::Int64(max_id) = *value {
        s.atom_put(max_id_key, AtomMapValue::Int64(max_id + 1));
        let mark_id = (max_id << scene::ID_BIT) | (type_ << scene::TYPE_BIT);
        let id = (max_id << scene::ID_BIT) | (tid << scene::TID_BIT) | (type_ << TYPE_BIT);
        s.put(mark_id, MapValue::Int64(id));
        return id;
    } else {
        panic!("max_id_key {} not exist", max_id_key)
    }
}

pub(crate) fn insert(s: &mut Scene, id: i64, kv_list: Vec<(i64, MapValue)>) {
    for (key, value) in kv_list {
        set_value(s, id, key, value);
    }
}

pub(crate) fn set_value(s: &mut Scene, id: i64, key: i64, value: MapValue) {
    s.put(id + key, value);
}

pub(crate) fn get_value(s: &Scene, id: i64) -> &MapValue {
    s.get(id)
}

pub(crate) fn try_get_value(s: &Scene, id: i64, def: MapValue) -> MapValue {
    let value = s.try_get(id);
    return if let Ok(map_value) = value {
        map_value
    } else {
        def
    }
}