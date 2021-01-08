pub(crate) mod mach;

use super::*;

pub enum ObjMaxId {
    Match,
    Fighter,
    Ability,
    Buff,
    Effect,
    Event,
    Action,
    Config
}


pub fn create(s: &mut scene::Scene, max_id_key: ObjMaxId) {
    s.put(max_id_key as i64, 1)
}

pub fn new_id(s: &mut scene::Scene, max_id_key: ObjMaxId) -> i64 {
    let max_id_key = max_id_key as i64;
    let max_id = s.get(max_id_key);
    s.put(max_id_key, max_id + 1);
    (max_id << scene::ID_BIT) | (max_id_key << scene::TYPE_BIT)
}