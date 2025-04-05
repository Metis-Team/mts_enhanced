#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Places the given cord type on the uniform of the player.
 *
 *  Parameter(s):
 *      0: OBJECT - Player unit to place cord type on.
 *      1: STRING - Cord type.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [player, "inf"] call mts_cords_fnc_placeCordOnUniform
 *
 */

params [["_player", objNull, [objNull]], ["_cordType", "", [""]]];

CHECK(!("PBW_German_Uniform" call ace_common_fnc_isModLoaded) || isNull _player);

private _camo = (uniform _player splitString "_") param [2, ""];

CHECK(_cordType isEqualTo "" || _camo isEqualTo "");

(_cordType splitString "_") params ["_unit", ["_cadet", ""]];

private _path = "";
if (_cadet isEqualTo "fa" || _cadet isEqualTo "oa") then {
    _path = format [QPATHTOF(data\cords\%1\%2\mts_cords_%1_%2_%3_co.paa), _unit, _camo, _cadet];
} else {
    if (_unit isEqualTo "inf") then {
        _path = format ["\german_uniforms\tex\pbw_schulterklappen%1_co.paa", _camo];
    } else {
        _path = format [QPATHTOF(data\cords\%1\%2\mts_cords_%1_%2_co.paa), _unit, _camo];
    };
};

_player setObjectTextureGlobal [2, _path];
