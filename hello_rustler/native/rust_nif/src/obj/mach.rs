use super::*;
use crate::obj;
use crate::scene::Atom::FightMatchId;
use crate::scene::{Atom, AtomMapValue, Scene};
use crate::team::*;

pub(crate) enum FightMatch {
    Tid = 2,
    Type,
    EventList,
    AtkRoleId,
    DefRoleId,
    AtkPriority,
    LevelRepress,
    StarRepress,
    AtkWarcraftId,
    DefWarcraftId,
    AtkWarcraftRound,
    DefWarcraftRound,
    AtkPassiveList,
    DefPassiveList,
    FighterList,
    Round,
    MaxRound,
    DelayDieList,
    AtkFighterList,
    DefFighterList,
    DieFighterList,
}

pub(crate) fn create(s: &mut Scene) -> i64 {
    let mach_id = obj::new_id(s, Atom::ObjMatchMaxId, obj::OBJ_MATCH);
    s.atom_put(Atom::FightMatchId, AtomMapValue::Int64(mach_id));
    mach_id
}

pub(crate) fn get_tid(s: &Scene) -> i64 {
    if let MapValue::Int64(&int_v) = get_field(s, FightMatchId::Tid) {
        return int_v;
    } else {
        panic!("FightMatch::Tid as is not MapValue::Int64")
    }
}

pub(crate) fn init(
    s: &mut Scene,
    atk_team: &TeamInfo,
    def_team: &TeamInfo,
    pool_fighters: Vec<i64>,
) {
    if let AtomMapValue::Int64(&match_id) = s.atom_get(Atom::FightMatchId) {
        obj::set_value(s, match_id, FightMatch::Round as i64, MapValue::Int64(1));
        // init_team(s, atk_team, def_team, pool_fighters)

        all_fighters = parser::parse(
            s: &mut Scene,
            atk_team: &TeamInfo,
            def_team: &TeamInfo,
            pool_fighters: Vec<i64>,
        );
        obj::set_value(
            s,
            match_id,
            FightMatch::FighterList as i64,
            MapValue::AllFighters(Box::new(all_fighters)),
        );
    }
    {
        panic!("Atom::FightMatchId not exist")
    }
}

pub(crate) fn get_atk_role_id() -> i64 {
    match s.atom_get(Atom::FightMatchId) {
        AtomMapValue::Int64(&match_id) => {
            let v = obj::try_get_value(match_id, FightMatch::AtkRoleId as i64, MapValue::Int64(0));
            if let MapValue::Int64(int_v) = v {
                return int_v;
            } else {
                panic!("FightMatch::AtkRoleId is not MapValue::Int64")
            }
        }
        _ => {
            panic!("Atom::FightMatchId not exist")
        }
    }
}

pub(crate) fn get_def_role_id() -> i64 {
    match s.atom_get(Atom::FightMatchId) {
        AtomMapValue::Int64(&match_id) => {
            let v = obj::try_get_value(match_id, FightMatch::DefRoleId as i64, MapValue::Int64(0));
            if let MapValue::Int64(int_v) = v {
                return int_v;
            } else {
                panic!("FightMatch::DefRoleId is not MapValue::Int64")
            }
        }
        _ => {
            panic!("Atom::FightMatchId not exist")
        }
    }
}

pub(crate) fn round(s: &Scene) -> i64 {
    get_field(s, FightMatch::Round).get_i64()
}

fn get_field(s: &Scene, field: FightMatch) -> &MapValue {
    match s.atom_get(Atom::FightMatchId) {
        AtomMapValue::Int64(&match_id) => obj::get_value(match_id, field as i64),
        _ => {
            panic!("Atom::FightMatchId not exist")
        }
    }
}
