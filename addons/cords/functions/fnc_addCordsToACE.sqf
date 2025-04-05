#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds all cords to the ACE interaction menu.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_cords_fnc_addCordsToACE
 *
 */

CHECK(!GVAR(enabled));

private _cordCondition = {(uniform ACE_player) in ["PBW_Uniform1_fleck","PBW_Uniform1H_fleck","PBW_Uniform1_tropen","PBW_Uniform1H_tropen","PBW_Uniform2_fleck","PBW_Uniform2_tropen","PBW_Uniform3K_fleck","PBW_Uniform3K_tropen","PBW_Uniform3_fleck","PBW_Uniform3_tropen","PBW_Uniform4K_fleck","PBW_Uniform4K_tropen","PBW_Uniform4_fleck","PBW_Uniform4_tropen"]};

private _cordAction = [
    QGVAR(cordAction),
    LLSTRING(cords),
    QPATHTOF(data\ui\mts_cords_ui_co.paa),
    {},
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions"], _cordAction] call ace_interact_menu_fnc_addActionToClass;

private _infCordAction = [
    QGVAR(infCordAction),
    LLSTRING(inf),
    QPATHTOF(data\ui\mts_cords_ui_inf_co.paa),
    {
        params ["", "_player"];
        [_player, "inf"] call FUNC(placeCordOnUniform);
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", QGVAR(cordAction)], _infCordAction] call ace_interact_menu_fnc_addActionToClass;

private _faCordAction = [
    QGVAR(faCordAction),
    LLSTRING(fa),
    QPATHTOF(data\ui\mts_cords_ui_fa_co.paa),
    {
        params ["", "_player"];
        [_player, "inf_fa"] call FUNC(placeCordOnUniform);
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", QGVAR(cordAction), QGVAR(infCordAction)], _faCordAction] call ace_interact_menu_fnc_addActionToClass;

private _oaCordAction = [
    QGVAR(oaCordAction),
    LLSTRING(oa),
    QPATHTOF(data\ui\mts_cords_ui_oa_co.paa),
    {
        params ["", "_player"];
        [_player, "inf_oa"] call FUNC(placeCordOnUniform);
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", QGVAR(cordAction), QGVAR(infCordAction)], _oaCordAction] call ace_interact_menu_fnc_addActionToClass;

private _pzCordAction = [
    QGVAR(pzCordAction),
    LLSTRING(pz),
    QPATHTOF(data\ui\mts_cords_ui_pz_co.paa),
    {
        params ["", "_player"];
        [_player, "pz"] call FUNC(placeCordOnUniform);
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", QGVAR(cordAction)], _pzCordAction] call ace_interact_menu_fnc_addActionToClass;

private _pzFACordAction = [
    QGVAR(pzFACordAction),
    LLSTRING(fa),
    QPATHTOF(data\ui\mts_cords_ui_fa_co.paa),
    {
        params ["", "_player"];
        [_player, "pz_fa"] call FUNC(placeCordOnUniform);
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", QGVAR(cordAction), QGVAR(pzCordAction)], _pzFACordAction] call ace_interact_menu_fnc_addActionToClass;

private _pzOACordAction = [
    QGVAR(pzOACordAction),
    LLSTRING(oa),
    QPATHTOF(data\ui\mts_cords_ui_oa_co.paa),
    {
        params ["", "_player"];
        [_player, "pz_oa"] call FUNC(placeCordOnUniform);
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", QGVAR(cordAction), QGVAR(pzCordAction)], _pzOACordAction] call ace_interact_menu_fnc_addActionToClass;
