use super::*;
use crate::scene::{Scene, Atom};

pub fn create(s: &mut Scene) -> i64 {
    let mach_id = obj::new_id(s, obj::ObjMaxId::Match);
    s.atom_put(Atom::ObjMatchMaxId, mach_id);
    mach_id
}