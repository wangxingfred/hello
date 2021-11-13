use crate::*;

use crate::scene::*;
use crate::record::*;
use crate::ftb::*;
use crate::tb::*;

use std::slice::Iter;

pub(crate) fn rule_init(s: &Scene, aim_tid: i64, params: &mut Iter<i64>) -> TargetAimRule {
    if aim_tid == 0 {
        return TargetAimRule{
            aim_tid,
            target_n: 0,
            hp_less: 0,
        }
    }

    let cfg = ftb_get_cfg(s, TARGET_RULE_CTX, aim_tid);
    let target_rule_cfg = cfg.target_rule_cfg();

    let init_func = &target_rule_cfg.init_func;
    match init_func {
        TargetRuleInitFunc::Default => TargetAimRule {
            aim_tid,
            target_n: 0,
            hp_less: 0,
        },
        TargetRuleInitFunc::NTarget => TargetAimRule {
            aim_tid,
            target_n: *params.next().unwrap(),
            hp_less: 0,
        },
        TargetRuleInitFunc::NHpLessP => TargetAimRule {
            aim_tid,
            target_n: *params.next().unwrap(),
            hp_less: *params.next().unwrap(),
        },
    }
}