#include "script_component.hpp"
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

private _playerIDs = parseSimpleArray GVAR(playerIDs);

CHECKRET(!(_playerIDs isEqualType []),ERROR("Wrong data type in CBA Settings. Expected ARRAY of STRINGS with player IDs"));

CHECK(!((getPlayerUID ACE_player) in _playerIDs));

private _majorRankAction = [
    QGVAR(majorRankAction),
    LLSTRING(major_rank),
    QPATHTOF(data\ui\mts_rank_major_ui_co.paa),
    {
        _player setObjectTextureGlobal [3, QPATHTOF(data\mts_rank_major_co.paa)];
    },
    {
        [_player] call FUNC(hasPBWUniform)
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", "ACE_Equipment"], _majorRankAction] call ace_interact_menu_fnc_addActionToClass;
