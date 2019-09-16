/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds mayonnaise to ACE.
 *      Adds the rank major to the ACE self interaction menu with the given player UID. The action itself places the texture on the PBW uniform.
 *      Player UIDs are defined in the CBA Settings.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_cords_fnc_addMajorToACE
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

private _playerIDs = parseSimpleArray GVAR(playerIDs);

CHECKRET(!(_playerIDs isEqualType []), ERROR("Wrong data type in CBA Settings. Expected ARRAY of STRINGS with player IDs"));

CHECK(!((getPlayerUID player) in _playerIDs));

private _cordCondition = {
    params ["", "_player"];
    (uniform _player) in ["PBW_Uniform1_fleck","PBW_Uniform1H_fleck","PBW_Uniform1_tropen","PBW_Uniform1H_tropen","PBW_Uniform2_fleck","PBW_Uniform2_tropen","PBW_Uniform3K_fleck","PBW_Uniform3K_tropen","PBW_Uniform3_fleck","PBW_Uniform3_tropen","PBW_Uniform4K_fleck","PBW_Uniform4K_tropen","PBW_Uniform4_fleck","PBW_Uniform4_tropen"]
};

private _majorRankAction = [
    QGVAR(majorRankAction),
    LLSTRING(major_rank),
    QPATHTOF(data\ui\mts_rank_major_ui_co.paa),
    {
        params ["", "_player"];
        _player setObjectTextureGlobal [3, QPATHTOF(data\mts_rank_major_co.paa)];
    },
    _cordCondition
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _majorRankAction] call ace_interact_menu_fnc_addActionToClass;
