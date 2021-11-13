use crate::ftb;
use crate::scene::*;
use crate::tb;
use crate::obj;
use crate::record::*;
use crate::obj::OBJ_ABILITY;

use super::*;

pub(crate) fn create(s: &mut Scene, tid: i64) {
    if let MapValue::Cfg(cfg) = ftb::ftb_get(s, ftb::ABILITY_CTX, tid) {
        if let tb::Cfg::Ability(ab_cfg) = &*cfg {
            let &AbilityCfg{
                tid,
                ..
            } = ab_cfg;
            let id = obj::new_id2(s, Atom::ObjAbilityMaxId, OBJ_ABILITY, tid);
            let eff_list = init_ability_effect(s, id, ab_cfg);
            let main_eff = eff_list[0];
        }
    }
}

fn init_ability_effect(s: &mut Scene, id: i64, ab_cfg: &AbilityCfg) -> Vec<(i64, i64)> {
    let &AbilityCfg {
        do_point,
        limit,
        limit_target,
        effect_target,
        effect_limit,
        effect,
        values,
        ..
    } = ab_cfg;
    let mut eff_list = Vec::with_capacity(do_point.len());
    let mut last_eff = (0, 0);
    for (i, point) in do_point.iter().enumerate()  {
        let (eff_id, eff_point) = effect::create(
            effect[i], id, point,
            limit[i], limit_target[i],
            effect_target[i], effect_limit[i], values[i], last_eff
        );
        last_eff = (eff_id, eff_point);
        eff_list.push(last_eff);
    }
    eff_list
}