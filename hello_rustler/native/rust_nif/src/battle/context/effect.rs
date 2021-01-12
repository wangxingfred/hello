use crate::*;
use super::*;

use crate::scene::*;
use crate::record::*;
use crate::ftb::*;
use crate::tb::*;



pub(crate) fn create(s: &Scene, tid: i64, source_id: i64, do_point: i64, limit_tid: i64, limit_target_tid: i64,
                     eff_target_tid: i64, eff_limit_tid: i64, args: &Vec<i64>, last_eff: (i64, i64)) {

    let eff_aim1 = battle::aim_rule::rule_init(s, limit_target_tid, args);

}