mod context;

use super::*;
use super::team::*;
use super::tb::{Tab, Cfg};
use super::record::*;
use super::obj::mach::{FightMatch};
use super::scene::MapValue;

pub(crate) fn create(s: &mut scene::Scene, role_id: i64, enemy_id: i64, fight_tid: i64, fight_id: i64,
                     atk_team: &TeamInfo, def_team: &TeamInfo, pool_fighters: Vec<i64>) {
    ftb::init(s, fight_tid, atk_team, def_team);
    let match_id = scene::create();
    if let Cfg::FightCfg(fight_cfg) = &*tb::get(Tab::FightCfg, fight_tid) {
        let fight_type = fight_cfg.type_;
        if let Cfg::FightTypeCfg(type_cfg) = &*tb::get(Tab::FightTypeCfg, fight_type) {
            obj::insert(s, match_id, vec![
                (FightMatch::Tid as i64, MapValue::Int64(fight_tid)),
                (FightMatch::Type as i64, MapValue::Int64(fight_type)),
                (FightMatch::AtkRoleId as i64, MapValue::Int64(role_id)),
                (FightMatch::DefRoleId as i64, MapValue::Int64(enemy_id)),
                (FightMatch::LevelRepress as i64, MapValue::Bool(type_cfg.level_repress)),
                (FightMatch::StarRepress as i64, MapValue::Bool(type_cfg.star_repress)),
                (FightMatch::AtkPriority as i64, MapValue::Bool(type_cfg.priority)),
            ]);

            flow::start(atk_team, def_team, pool_fighters)
        }
    }
}