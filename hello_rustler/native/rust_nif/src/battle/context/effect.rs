use crate::*;
use super::*;

use crate::scene::*;
use crate::record::*;
use crate::ftb::*;
use crate::tb::*;
use crate::obj::OBJ_EFFECT;


pub(crate) fn create(s: &mut Scene, tid: i64, source_id: i64, do_point: i64, limit_tid: i64, limit_target_tid: i64,
                     eff_target_tid: i64, eff_limit_tid: i64, args: &Vec<i64>, last_eff: (i64, i64)) {

    let mut data = args.iter();

    let eff_aim1 = battle::aim_rule::rule_init(s, limit_target_tid, &mut data);
    let (do_limits1, _) = battle::limit_rule::init(s, limit_tid, 0, &mut data);

    let eff_aim2 = battle::aim_rule::rule_init(s, eff_target_tid, &mut data);
    let (do_limits2, _) = battle::limit_rule::init(s, eff_limit_tid, 0, &mut data);

    let mut params = Vec::with_capacity(data.len());
    for &param in data {
        params.push(param);
    }

    let id = obj::new_id2(s, Atom::ObjEffectMaxId, OBJ_EFFECT, tid);
    let eff = obj::Effect{
        tid,
        source_id,
        point: do_point,
        last_eff,
        pre_aim_rule: eff_aim1,
        pre_limit_rule: do_limits1,
        pre_aim_list: vec![],
        do_aim_rule: eff_aim2,
        do_limit_rule: do_limits2,
        do_aim_list: vec![],
        do_round: 0,
        parameter: params,
        hit_aim_list: vec![]
    };
    obj::insert(s, id, eff)
}