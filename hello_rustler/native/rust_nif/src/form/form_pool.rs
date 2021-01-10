use crate::constants::*;

pub(crate) struct PoolFighterKey {
    role_id: i64,
    uid: i64,
    tid: i64,
    team: i64,
    loc: i64,
    fight_tid: i64
}

pub(crate) fn key(fighter_type: i64, role_id: i64, uid: i64, tid: i64, team: i64, loc: i64, fight_tid: i64) -> PoolFighterKey {
    if fighter_type == FIGHTER_ROLE_HERO {
        hero_key(role_id, uid, team)
    } else {
        npc_key(tid, team, loc, fight_tid)
    }
}

fn hero_key(role_id: i64, uid: i64, team: i64) -> PoolFighterKey {
    PoolFighterKey {
        role_id,
        uid,
        tid: 0,
        team,
        loc: 0,
        fight_tid: 0
    }
}

fn npc_key(tid: i64, team: i64, loc: i64, fight_tid: i64) -> PoolFighterKey {
    PoolFighterKey {
        role_id: 0,
        uid: 0,
        tid,
        team,
        loc,
        fight_tid
    }
}