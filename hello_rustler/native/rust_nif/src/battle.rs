use super::*;
use super::team::*;

pub(crate) fn create(s: &mut scene::Scene, role_id: i64, enemy_id: i64, fight_tid: i64, fight_id: i64,
              atk_team: &TeamInfo, def_team: &TeamInfo) {
    ftb::init(s, fight_tid, atk_team, def_team)
}