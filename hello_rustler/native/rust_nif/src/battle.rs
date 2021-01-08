use super::*;

pub fn create(s: &mut scene::Scene, role_id: i64, enemy_id: i64, fight_tid: i64, fight_id: i64, atk_team: i64, def_team: i64) {
    tb:init(s, fight_tid, atk_team, def_team)
}