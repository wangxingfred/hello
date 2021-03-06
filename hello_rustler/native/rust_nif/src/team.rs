pub(crate) const FT_ASSAULT: i64 = 1;
pub(crate) const FT_GUARD: i64 = 2;


pub(crate) struct FighterInfo {
    pub tid: i64,
    pub type_: i64,
    pub role_type: i64,
    pub uid: i64,
    pub role: i64,
    pub style: i64,
    pub name: i64,
    pub camp: i64,
    pub profession: i64,
    pub team: i64,
    pub loc: i64,
    pub star: i64,
    pub level: i64,
    pub attack: i64,
    pub defense: i64,
    pub hp: i64,
    pub speed: i64,
    pub atk_pp: i64,
    pub defense_pp: i64,
    pub hp_pp: i64,
    pub ab_deepen: i64,
    pub dodge: i64,
    pub hit: i64,
    pub wreck: i64,
    pub parry: i64,
    pub parry_reduce: i64,
    pub crit: i64,
    pub crit_resist: i64,
    pub crit_ratio: i64,
    pub crit_harm: i64,
    pub breaking: i64,
    pub ctrl_resist: i64,
    pub reduce: i64,
    pub rel_harm: i64,
    pub normal_ab: i64,
    pub anger_ab: i64,
    pub attr_ab: i64,
    pub passive_ab: i64,
    pub genius_ab: i64,
    pub fetter_ab_list: Vec<i64>,
}

pub(crate) struct FightHaloRate {
    pub attack_rate: f32,
    pub hp_rate: f32
}

pub(crate) struct TeamInfo {
    pub team: i64,
    pub power: i64,
    pub fighter: Vec<FighterInfo>,
    warcraft: i64,
    warcraft_star: i32,
    warcraft_level: i32,
    pub passive: Vec<i64>,
    pub halo: Option<FightHaloRate>,
    pub fetter_team_ab_list: Vec<i64>,
}