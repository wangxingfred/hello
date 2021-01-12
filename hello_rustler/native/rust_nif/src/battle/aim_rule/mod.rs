use crate::*;

use crate::scene::*;
use crate::record::*;
use crate::ftb::*;
use crate::tb::*;

pub(crate) fn rule_init(s: &Scene, aim_tid: i64, params: &Vec<i64>) -> TargetAimRule {
    if aim_tid == 0 {
        return TargetAimRule{
            aim_tid,
            target_n: 0,
            hp_less: 0,
            params: vec![]
        }
    }

    let cfg = ftb_get_cfg(s, TARGET_RULE_CTX, aim_tid);
    let target_rule_cfg = cfg.target_rule_cfg();

    let init_func = &target_rule_cfg.init_func;
    let params_len = params.len();
    match init_func {
        TargetRuleInitFunc::Default => TargetAimRule {
            aim_tid,
            target_n: 0,
            hp_less: 0,
            params: params.clone(),
        },
        TargetRuleInitFunc::NTarget => TargetAimRule {
            aim_tid,
            target_n: params[0],
            hp_less: 0,
            params: if params_len > 1 { params[1..].clone() } else { vec![] },
        },
        TargetRuleInitFunc::NHpLessP => TargetAimRule {
            aim_tid,
            target_n: params[0],
            hp_less: params[1],
            params: if params_len > 2 { params[2..].clone() } else { vec![] },
        },
    }
}