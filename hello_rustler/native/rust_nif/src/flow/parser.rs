use super::team::*;
use super::scene::*;
use crate::*;
use super::form::*;
use super::constants::*;

pub(crate) fn parse(s: &mut Scene, atk_team: &TeamInfo, def_team: &TeamInfo, pool_fighters: &Vec<i64>) {
    let mut atk_team_fighters = parse_team(s, obj::mach::get_atk_role_id(), atk_team, pool_fighters);
    let mut def_team_fighters = parse_team(s, obj::mach::get_def_role_id(), def_team, pool_fighters);
    atk_team_fighters.append(&mut def_team_fighters);
}

fn parse_team(s: &mut Scene, role_id: i64, team: &TeamInfo, pool_fighters: &Vec<i64>) -> Vec<i64> {
    let TeamInfo {
        team: &team,
        fighter: info_list,
        passive: passive_tid_list,
        fetter_team_ab_list: fetter_team_ab_list,
        ..
    } = team;
    let warcraft_id = 0;
    let attr_l = vec![];

    let mut passive_ab_tid_l = passive_tid_list.clone();
    passive_ab_tid_l.extend(fetter_team_ab_list.iter());

    let fighter_id_l = parse_sprite(s, role_id, team, info_list, &attr_l, pool_fighters, &passive_ab_tid_l);
}

fn parse_sprite(s: &mut Scene, role_id: i64, team: i64, fighter_info_l: &Vec<FighterInfo>, attr_l: &Vec<i64>, pool_fighters: &Vec<i64>, passive_ab_tid_l: &Vec<i64>) {
    let mut sprites = Vec::new();
    for fighter_info in fighter_info_l {
        let &FighterInfo {
            role_type,
            uid,
            tid,
            loc,
            ..
        } = fighter_info;

        // let key = form_pool::key(role_type, role_id, uid, tid, team, loc, obj::mach::get_tid());
        sprites.push(parse_sprite_(s, team, fighter_info, attr_l, passive_ab_tid_l));
    }
}

fn parse_sprite_(s: &mut Scene, team: i64, fighter_info: &FighterInfo, attr_l: &Vec<i64>, passive_ab_tid_l: &Vec<i64>) {
    let &FighterInfo {
        hp,
        loc,
        anger_ab,
        normal_ab,
        passive_ab,
        attr_ab,
        genius_ab,
        fetter_ab_list,
        ..
    } = fighter_info;

    ability::context::create(s, anger_ab);
    ability::context::create(s, normal_ab);
    ability::context::create(s, passive_ab);
    ability::context::create(s, attr_ab);
    ability::context::create(s, genius_ab);

    for passive_ab in passive_ab_tid_l {
        if ability::cfg_type_equal(s, passive_ab, TID_FIGHT_AB_PASSIVE) {
            ability::context::create(s, passive_ab);
        }
    }
    for fetter_ab in fetter_ab_list {
        ability::context::create(s, fetter_ab);
    }
}
