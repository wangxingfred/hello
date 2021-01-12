use crate::*;

use crate::scene::*;
use crate::record::*;
use crate::ftb::*;
use crate::tb::*;
use std::slice::Iter;

pub(crate) fn init(s: &Scene, do_limit_tid: i64, over_limit_tid: i64, params: &Vec<i64>) {
    let cfg = ftb_get_cfg(s, LIMIT_RULE_CTX, do_limit_tid);
    let do_limit_rule_cfg = cfg.limit_rule();
    let do_limit_l = &do_limit_rule_cfg.limits;

    let cfg = ftb_get_cfg(s, LIMIT_RULE_CTX, over_limit_tid);
    let over_limit_rule_cfg = cfg.limit_rule();
    let over_limit_l = &over_limit_rule_cfg.limits;

    init_limit(s, do_limit_l, params.iter())
}

fn init_limit(s: &Scene, do_limit_l: &Vec<i64>, mut params: Iter<i64>) {
    let mut limits = Vec::with_capacity(do_limit_l.len());
    for &tid in do_limit_l {
        if tid == 0 { continue; };

        let cfg = ftb_get_cfg(s, LIMIT_RULE_CTX, tid);
        let limit_rule_cfg = cfg.limit_rule();

        let &value = params.next().unwrap();

        let limit = match limit_rule_cfg.init_f {
            LimitRuleInitFunc::InitDefault => LimitRule{
                v1: value,
                v2: 0,
                v3: vec![]
            },
            LimitRuleInitFunc::InitLimitSize => {}
            LimitRuleInitFunc::InitLimitInterval => {}
            LimitRuleInitFunc::InitLimitRound => {}
            LimitRuleInitFunc::InitFighterNum => {}
            LimitRuleInitFunc::InitFighterRoundNum => {}
        };
        limits.push(limit);
    }
}