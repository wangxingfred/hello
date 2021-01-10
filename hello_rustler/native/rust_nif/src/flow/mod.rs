mod parser;

use super::team::*;
use super::scene::*;
use super::*;


pub(crate) fn start(s: &mut Scene, atk_team: &TeamInfo, def_team: &TeamInfo, pool_fighters: Vec<i64>) {

    let (atk_halo1, atk_halo2) =
        if let Some(FightHaloRate{attack_rate, hp_rate}) = atk_team.halo {
            (attack_rate, hp_rate)
        } else {
            (0.0, 0.0)
        };

    let (def_halo1, def_halo2) =
        if let Some(FightHaloRate{attack_rate, hp_rate}) = def_team.halo {
            (attack_rate, hp_rate)
        } else {
            (0.0, 0.0)
        };

    obj::mach::init(s, atk_team, def_team, pool_fighters);
}