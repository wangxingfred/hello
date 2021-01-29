use crate::*;

use crate::ftb::*;
use crate::record::*;
use crate::scene::*;
use crate::tb::*;
use std::slice::Iter;

pub(crate) fn init(s: &Scene, do_limit_tid: i64, over_limit_tid: i64, params: &mut Iter<i64>)
                   -> (Vec<(i64, LimitRule)>, Option<Vec<(i64, LimitRule)>>) {
    let cfg = ftb_get_cfg(s, LIMIT_RULE_CTX, do_limit_tid);
    let do_limit_rule_cfg = cfg.limit_rule();
    let do_limit_l = &do_limit_rule_cfg.limits;
    let do_limits = init_limit(s, do_limit_l, params);

    if over_limit_tid == 0 {
        (do_limits, Option::None)
    } else {
        let cfg = ftb_get_cfg(s, LIMIT_RULE_CTX, over_limit_tid);
        let over_limit_rule_cfg = cfg.limit_rule();
        let over_limit_l = &over_limit_rule_cfg.limits;
        let over_limits = init_limit(s, over_limit_l, params);
        (do_limits, Option::Some(over_limits))
    }

}

fn init_limit(s: &Scene, do_limit_l: &Vec<i64>, params: &mut Iter<i64>) -> Vec<(i64, LimitRule)> {
    let mut limits = Vec::with_capacity(do_limit_l.len());
    for &tid in do_limit_l {
        if tid == 0 {
            continue;
        };

        let cfg = ftb_get_cfg(s, LIMIT_RULE_CTX, tid);
        let limit_rule_cfg = cfg.limit_rule();

        let &value = params.next().unwrap();

        let limit = match limit_rule_cfg.init_f {
            LimitRuleInitFunc::InitDefault => LimitRule::Default(value),
            LimitRuleInitFunc::InitLimitSize => LimitRule::LimitSize(value, 0),
            LimitRuleInitFunc::InitLimitInterval => LimitRule::LimitInterval(value, obj::mach::round(s) + value),
            LimitRuleInitFunc::InitLimitRound => LimitRule::LimitRound(obj::mach::round(s) + value - 1),
            LimitRuleInitFunc::InitFighterNum => LimitRule::FighterNum(value, vec![]),
            LimitRuleInitFunc::InitFighterRoundNum => LimitRule::FighterRoundNum(value, 1, vec![]),
        };
        limits.push((tid, limit));
    }
    limits
}
