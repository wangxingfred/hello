use super::scene::*;
use super::record::*;

pub(crate) enum Tab {
    AbilityCfg,
    LimitRuleCfg,
    AbilityEffectCfg,
    AbilityEffectTypeCfg,
    FightBuffCfg,
    FightBuffEffectCfg,
    TargetRuleCfg,
    FightPointCfg,
    FightCfg,
    FightTypeCfg,
    FightRepressTypeCfg,
    FightStarRepressCfg,
    FightLevelRepressCfg
}

pub(crate) enum Cfg {
    None,
    Ability(AbilityCfg),
    LimitRule(LimitRule),
    AbilityEffect(AbilityEffect),
    FightBuffCfg(FightBuffCfg),
    FightBuffEffectCfg(FightBuffEffectCfg),
    TargetRuleCfg(TargetRuleCfg),
    FightPointCfg(FightPointCfg),
    FightCfg(FightCfg),
    FightTypeCfg(FightTypeCfg),
    FightRepressTypeCfg(FightRepressTypeCfg),
    FightStarRepressCfg(FightStarRepressCfg),
    FightLevelRepressCfg(FightLevelRepressCfg),
}

pub(crate) fn get(_tab: Tab, _tid: i64) -> Box<Cfg> {
    return Box::new(Cfg::None);
}

pub(crate) fn all(_tab: Tab) -> Vec<Box<Cfg>> {
    return vec![];
}