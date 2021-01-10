use super::scene::*;
use super::team::*;
use crate::record::*;
use super::tb;
use super::tb::Tab;
use super::tb::Cfg;
use std::borrow::Borrow;
use std::ops::Deref;

// 配置数据类型（主要是用来缓存战斗配置表中的数据类型）
pub(crate) const FIGHT_BUFF_EFFECT_CTX: i32 = 16;
pub(crate) const FIGHT_BUFF_CTX: i32 = 17;
pub(crate) const FIGHT_EVENT_EFFECT_CTX: i32 = 18;
pub(crate) const FIGHT_EVENT_CTX: i32 = 19;
pub(crate) const FIGHT_REPRESS_TYPE_CTX: i32 = 20;
pub(crate) const FIGHT_STAR_REPRESS_CTX: i32 = 21;
pub(crate) const FIGHT_LEVEL_REPRESS_CTX: i32 = 22;
pub(crate) const ABILITY_EFFECT_TYPE_CTX: i32 = 23;
pub(crate) const ABILITY_EFFECT_CTX: i32 = 24;
pub(crate) const ABILITY_CTX: i32 = 25;
pub(crate) const FIGHT_ABILITY_TYPE_CTX: i32 = 26;
pub(crate) const LIMIT_RULE_CTX: i32 = 27;
pub(crate) const TARGET_RULE_CTX: i32 = 28;
pub(crate) const FIGHT_POINT_CTX: i32 = 29;
pub(crate) const ABILITY_EXTRA_ATTR_CTX: i32 = 30;

const TID_BUFF_VALUE_SHIELD: i64 = 1612;

pub(crate) fn init(s: &mut Scene, fight_tid: i64, atk_team: &TeamInfo, def_team: &TeamInfo) {
    init_team(s, atk_team);
    init_team(s, def_team);

    init_target_rules(s);
    init_fight_points(s);

    insert_buff(s, TID_BUFF_VALUE_SHIELD);

    if let Cfg::FightCfg(fight_cfg) = &*tb::get(Tab::FightCfg, fight_tid) {
        let fight_type = fight_cfg.type_;
        if let Cfg::FightTypeCfg(type_cfg) = &*tb::get(Tab::FightTypeCfg, fight_type) {

            if type_cfg.star_repress || type_cfg.level_repress {
                let repress_list = tb::all(Tab::FightRepressTypeCfg);
                for repress_cfg in repress_list {
                    let mut tid = 0;
                    if let Cfg::FightRepressTypeCfg(repress) = &*repress_cfg {
                        tid = repress.tid
                    }
                    if tid > 0 {
                        insert_record(s, repress_cfg, FIGHT_REPRESS_TYPE_CTX, tid);
                    }
                }
            }

            if type_cfg.star_repress {
                insert_star_repress(s)
            }
            if type_cfg.level_repress {
                insert_star_repress(s)
            }
        }
    }
}

pub(crate) fn insert(s: &mut Scene, tab: Tab, tab_key: i32, tid: i64) {
    let cfg = tb::get(tab, tid);
    insert_record(s, cfg, tab_key, tid);
}

pub(crate) fn get(s: &Scene, tab_key: i32, tid: i64) -> &MapValue {
    let id = (tid << TID_BIT) | (tab_key << TYPE_BIT);
    s.get(id)
}


fn init_team(s: &mut Scene, team_info: &TeamInfo) {
    let TeamInfo {
        fighter,
        passive,
        fetter_team_ab_list,
        ..
    } = team_info;
    insert_ability_list(s, fetter_team_ab_list);
    insert_ability_list(s, passive);

    for f in fighter {
        let FighterInfo {
            tid,
            anger_ab,
            attr_ab,
            passive_ab,
            genius_ab,
            fetter_ab_list,
            ..
        } = f;
        insert_ability(s, *tid);
        insert_ability(s, *anger_ab);
        insert_ability(s, *attr_ab);
        insert_ability(s, *passive_ab);
        insert_ability(s, *genius_ab);
        insert_ability_list(s, fetter_ab_list);
    }
}

fn insert_ability_list(s: &mut Scene, list: &Vec<i64>) {
    for &tid in list {
        insert_ability(s, tid)
    }
}

fn insert_ability(s: &mut Scene, tid: i64) {
    let cfg = tb::get(tb::Tab::AbilityCfg, tid);
    if let Cfg::Ability(ability) = cfg.borrow() {

        // [insert(?FightPointCfg, ?FIGHT_POINT_CTX, Point) || Point <- PointL],
        // [insert(?TargetRuleCfg, ?TARGET_RULE_CTX, LimitTarget) || LimitTarget <- LimitTargetL],
        // [insert(?TargetRuleCfg, ?TARGET_RULE_CTX, EffectTarget) || EffectTarget <- EffectTargetL],

        for &limit in &ability.limit {
            insert_limit_rule(s, limit as i64);
        }
        for &limit in &ability.effect_limit {
            insert_limit_rule(s, limit as i64);
        }
        for &effect in &ability.effect {
            insert_ability_effect(s, effect as i64);
        }

        insert_record(s, cfg, ABILITY_CTX, tid);
    }
}

fn insert_limit_rule(s: &mut Scene, tid: i64) {
    let cfg = tb::get(tb::Tab::LimitRuleCfg, tid);
    if let Cfg::LimitRule(rule) = cfg.borrow() {
        let limits = rule.limits.clone();
        insert_record(s, cfg, LIMIT_RULE_CTX, tid);
        for limit in limits {
            insert_limit_rule(s, limit)
        }
    }
}

fn insert_ability_effect(s: &mut Scene, tid: i64) {
    let cfg = tb::get(tb::Tab::AbilityEffectCfg, tid);
    if let Cfg::AbilityEffect(ab_effect) = cfg.borrow() {
        insert(s, Tab::AbilityEffectTypeCfg, ABILITY_EFFECT_TYPE_CTX, ab_effect.type_);
        insert_buff_list(s, &ab_effect.buff);
        insert_record(s, cfg, ABILITY_EFFECT_CTX, tid)
    }
}

fn insert_buff_list(s: &mut Scene, buff_list: &Vec<i64>) {
    for &buff_tid in buff_list {
        insert_buff(s, buff_tid)
    }
}

fn insert_buff(s: &mut Scene, buff_tid: i64) {
    let cfg = tb::get(Tab::FightBuffCfg, buff_tid);
    if let Cfg::FightBuffCfg(buff_cfg) = &*cfg {
        // insert(?FightPointCfg, ?FIGHT_POINT_CTX, Point),
        insert_limit_rule(s, buff_cfg.do_limit);
        insert_limit_rule(s, buff_cfg.over_limit);
        for &eff_tid in &buff_cfg.eff {
            insert_buff_effect(s, eff_tid);
        }
        insert_record(s, cfg, FIGHT_BUFF_CTX, buff_tid);
    }
}

fn insert_buff_effect(s: &mut Scene, eff_tid: i64) {
    let cfg = tb::get(Tab::FightBuffEffectCfg, eff_tid);
    if let Cfg::FightBuffEffectCfg(effect) = &*cfg {
        insert_buff(s, effect.buff_tid);
        insert_record(s, cfg, FIGHT_BUFF_EFFECT_CTX, eff_tid);
    }
}

fn init_target_rules(s: &mut Scene) {
    let rules = tb::all(Tab::TargetRuleCfg);
    for cfg in rules {
        if let Cfg::TargetRuleCfg(rule) = cfg.borrow() {
            let tid = rule.tid;
            insert_record(s, cfg, TARGET_RULE_CTX, tid)
        }
    }
}

fn init_fight_points(s: &mut Scene) {
    for cfg in tb::all(Tab::FightPointCfg) {
        if let Cfg::FightPointCfg(point) = cfg.borrow() {
            let tid = point.tid;
            insert_record(s, cfg, FIGHT_POINT_CTX, tid)
        }
    }
}


fn insert_record(s: &mut Scene, record: Box<Cfg>, table_key: i32, tid: i64) {
    let id = (tid << TID_BIT) | ((table_key as i64) << TYPE_BIT);
    if let false = s.contains(id) {
        s.put(id, MapValue::Cfg(record))
    }
}

fn insert_star_repress(s: &mut Scene) {
    for cfg in tb::all(Tab::FightStarRepressCfg) {
        if let Cfg::FightStarRepressCfg(x) = &*cfg {
            let tid = x.tid;
            insert_record(s, cfg, FIGHT_STAR_REPRESS_CTX, tid);
        }
    }
}

fn insert_level_repress(s: &mut Scene) {
    for cfg in tb::all(Tab::FightLevelRepressCfg) {
        if let Cfg::FightLevelRepressCfg(x) = &*cfg {
            let tid = x.tid;
            insert_record(s, cfg, FIGHT_LEVEL_REPRESS_CTX, tid);
        }
    }
}