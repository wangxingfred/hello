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
    FightLevelRepressCfg,
}

pub(crate) enum Cfg {
    None,
    Ability(AbilityCfg),
    LimitRuleCfg(LimitRuleCfg),
    AbilityEffectCfg(AbilityEffectCfg),
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

impl Cfg {
    pub(crate) fn ability(&self) -> &AbilityCfg {
        if let &Cfg::Ability(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn limit_rule(&self) -> &LimitRuleCfg {
        if let &Cfg::LimitRuleCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn ability_effect(&self) -> &AbilityEffectCfg {
        if let &Cfg::AbilityEffectCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_buff_cfg(&self) -> &FightBuffCfg {
        if let &Cfg::FightBuffCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_buff_effect_cfg(&self) -> &FightBuffEffectCfg {
        if let &Cfg::FightBuffEffectCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn target_rule_cfg(&self) -> &TargetRuleCfg {
        if let &Cfg::TargetRuleCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_point_cfg(&self) -> &FightPointCfg {
        if let &Cfg::FightPointCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_cfg(&self) -> &FightCfg {
        if let &Cfg::FightCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_type_cfg(&self) -> &FightTypeCfg {
        if let &Cfg::FightTypeCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_repress_type_cfg(&self) -> &FightRepressTypeCfg {
        if let &Cfg::FightRepressTypeCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_star_repress_cfg(&self) -> &FightStarRepressCfg {
        if let &Cfg::FightStarRepressCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
    pub(crate) fn fight_level_repress_cfg(&self) -> &FightLevelRepressCfg {
        if let &Cfg::FightLevelRepressCfg(cfg) = &self { cfg } else { panic!("invalid cfg") }
    }
}

pub(crate) fn tb_get(_tab: Tab, _tid: i64) -> Box<Cfg> {
    return Box::new(Cfg::None);
}

pub(crate) fn tb_all(_tab: Tab) -> Vec<Box<Cfg>> {
    return vec![];
}