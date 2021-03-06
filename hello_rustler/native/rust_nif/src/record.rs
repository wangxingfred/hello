pub(crate) trait Record {
    fn name(&self) -> String;
}

// ----------------------------------
pub(crate) struct EmptyRecord {}

impl Record for EmptyRecord {
    fn name(&self) -> String {
        return String::from("");
    }
}

// ----------------------------------
pub(crate) struct AbilityCfg {
    pub(crate) tid: i64,
    pub(crate) type_: i64,
    pub(crate) name: i64,
    pub(crate) do_point: Vec<i64>,
    pub(crate) limit_target: Vec<i64>,
    pub(crate) limit: Vec<i64>,
    pub(crate) effect_target: Vec<i64>,
    pub(crate) effect_limit: Vec<i64>,
    pub(crate) effect: Vec<i64>,
    pub(crate) values: Vec<i64>,
}

impl Record for AbilityCfg {
    fn name(&self) -> String {
        String::from("AbilityCfg")
    }
}

// ----------------------------------
// pub(crate) struct TargetRule {
//     tid: i64,
//     team: i64,
//     init_func: i64,
//     select_func: i64,
//     sort_func: i64,
//     filter_func: i64,
//     args: i64,
// }
// impl Record for TargetRule {
//     fn name(&self) -> String {
//         String::from("TargetRule")
//     }
// }

// ----------------------------------
pub(crate) enum LimitRule {
    Default(i64),
    LimitSize(i64,i64),
    LimitInterval(i64,i64),
    LimitRound(i64),
    FighterNum(i64, Vec<i64>),
    FighterRoundNum(i64, i64, Vec<i64>)
}
pub(crate) enum LimitRuleInitFunc {
    InitDefault,
    InitLimitSize,
    InitLimitInterval,
    InitLimitRound,
    InitFighterNum,
    InitFighterRoundNum
}
pub(crate) struct LimitRuleCfg {
    pub(crate) tid: i64,
    pub(crate) init_f: LimitRuleInitFunc,
    pub(crate) update_f: i64,
    pub(crate) check_f: i64,
    pub(crate) args: i64,
    pub(crate) limits: Vec<i64>,
}

impl Record for LimitRuleCfg {
    fn name(&self) -> String {
        String::from("limit_rule")
    }
}

// ----------------------------------
pub(crate) struct AbilityEffectCfg {
    pub(crate) tid: i64,
    pub(crate) type_: i64,
    pub(crate) buff: Vec<i64>,
    pub(crate) arg: i64,
}

impl Record for AbilityEffectCfg {
    fn name(&self) -> String {
        String::from("ability_effect")
    }
}

// ----------------------------------
pub(crate) struct FightBuffCfg {
    pub(crate) tid: i64,
    pub(crate) type_: i64,
    pub(crate) not_dispel: i64,
    pub(crate) ignor_shield: i64,
    pub(crate) is_ctrl: i64,
    pub(crate) point: i64,
    pub(crate) overlay: i64,
    pub(crate) do_limit: i64,
    pub(crate) over_limit: i64,
    pub(crate) eff: Vec<i64>,
}

impl Record for FightBuffCfg {
    fn name(&self) -> String {
        String::from("fight_buff_cfg")
    }
}

// ----------------------------------
pub(crate) struct FightBuffEffectCfg {
    pub(crate) tid: i64,
    pub(crate) module: i64,
    pub(crate) buff_tid: i64,
    pub(crate) extra_aim: i64,
    pub(crate) arg: i64,
}

impl Record for FightBuffEffectCfg {
    fn name(&self) -> String {
        String::from("fight_buff_effect_cfg")
    }
}

// ----------------------------------
pub(crate) enum TargetRuleInitFunc {
    Default,
    NTarget,
    NHpLessP,
}

pub(crate) struct TargetAimRule {
    pub(crate) aim_tid: i64,
    pub(crate) target_n: i64,
    pub(crate) hp_less: i64,
}

pub(crate) struct TargetRuleCfg {
    pub(crate) tid: i64,
    pub(crate) team: i64,
    pub(crate) init_func: TargetRuleInitFunc,
    pub(crate) select_func: i64,
    pub(crate) sort_func: i64,
    pub(crate) filter_func: i64,
    pub(crate) args: i64,
}

impl Record for TargetRuleCfg {
    fn name(&self) -> String {
        String::from("target_rule_cfg")
    }
}

// ----------------------------------
pub(crate) struct FightPointCfg {
    pub(crate) tid: i64,
    pub(crate) buff_aim: i64,
}

impl Record for FightPointCfg {
    fn name(&self) -> String {
        String::from("fight_point_cfg")
    }
}

// ----------------------------------
pub(crate) struct FightCfg {
    pub(crate) tid: i64,
    pub(crate) type_: i64,
    pub(crate) need_formation: i64,
    pub(crate) formation_rule: i64,
    pub(crate) team_count: i64,
    pub(crate) atk_team: i64,
    pub(crate) def_team: i64,
    pub(crate) exit: i64,
}

impl Record for FightCfg {
    fn name(&self) -> String {
        String::from("fight_type_cfg")
    }
}


// ----------------------------------
pub(crate) struct FightTypeCfg {
    pub(crate) tid: i64,
    pub(crate) database: i64,
    pub(crate) priority: bool,
    pub(crate) level_repress: bool,
    pub(crate) star_repress: bool,
    pub(crate) inherit: i64,
    pub(crate) is_mirror: i64,
    pub(crate) battle_rule: i64,
    pub(crate) formation_inherit: i64,
    pub(crate) is_report: i64,
}

impl Record for FightTypeCfg {
    fn name(&self) -> String {
        String::from("fight_type_cfg")
    }
}

// ----------------------------------
pub(crate) struct FightRepressTypeCfg {
    pub(crate) tid: i64,
    pub(crate) star: bool,
    pub(crate) level: bool,
}

impl Record for FightRepressTypeCfg {
    fn name(&self) -> String {
        String::from("fight_repress_type_cfg")
    }
}

// ----------------------------------
pub(crate) struct FightStarRepressCfg {
    pub(crate) tid: i64,
    pub(crate) role_positive_attack: bool,
    pub(crate) role_negative_attack: bool,
    pub(crate) npc_positive_attack: i64,
    pub(crate) npc_negative_attack: bool,
    pub(crate) npc_positive_ctrl: bool,
    pub(crate) npc_negative_ctrl: i64,
    pub(crate) npc_positive_wreck: bool,
    pub(crate) npc_negative_wreck: bool,
    pub(crate) npc_positive_crit: i64,
    pub(crate) npc_negative_crit: bool,
}

impl Record for FightStarRepressCfg {
    fn name(&self) -> String {
        String::from("fight_star_repress_cfg")
    }
}

// ----------------------------------
pub(crate) struct FightLevelRepressCfg {
    pub(crate) tid: i64,
    pub(crate) role_positive_attack: bool,
    pub(crate) role_negative_attack: bool,
    pub(crate) npc_positive_attack: i64,
    pub(crate) npc_negative_attack: bool,
    pub(crate) npc_positive_ctrl: bool,
    pub(crate) npc_negative_ctrl: i64,
}

impl Record for FightLevelRepressCfg {
    fn name(&self) -> String {
        String::from("fight_level_repress_cfg")
    }
}
