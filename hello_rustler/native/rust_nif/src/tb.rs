use super::scene::Scene;
use super::team::*;

pub fn init(s: &mut Scene, tid: i64, atk_team: &TeamInfo, def_team: &TeamInfo) {
    init_team(s, atk_team);
    init_team(s, def_team);
}

pub fn insert() {

}

fn init_team(s: &mut Scene, team_info: &TeamInfo) {

}

fn insert_ability_list(s: &mut Scene, list: &Vec<i64>) {
    for &tid in list {
        insert_ability(s, tid)
    }
}

fn insert_ability(s: &mut Scene, tid: i64) {
    let cfg = get_ability_cfg(tid);
    insert_record(s, &cfg, 2, tid)
}

fn insert_record(s: &mut Scene, record: &AbilityCfg, table_key: i32, tid: i64) {

}

fn get_ability_cfg(tid: i64) -> AbilityCfg {
    AbilityCfg {
        tid,
        type_: 0,
        name: 0,
        do_point: vec![],
        limit_target: vec![],
        limit: vec![],
        effect_target: vec![],
        effect_limit: vec![],
        effect: vec![],
        values: vec![]
    }
}

struct AbilityCfg {
    tid: i64,
    type_: i32,
    name: i32,
    do_point: Vec<i32>,
    limit_target: Vec<i32>,
    limit: Vec<i32>,
    effect_target: Vec<i32>,
    effect_limit: Vec<i32>,
    effect: Vec<i32>,
    values: Vec<i32>,
}