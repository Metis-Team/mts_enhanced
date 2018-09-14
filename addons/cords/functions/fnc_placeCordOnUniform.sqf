/**
 *  Author: Timi007
 *
 *  Description:
 *      Places the given cord type on the uniform of the player.
 *
 *  Parameter(s):
 *      0: string - cord type
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["inf"] call mts_cords_fnc_placeCordOnUniform
 *
 */
#include "script_component.hpp"
params[["_cordType","",[""]]];
private["_path"];

private _camo = (uniform player splitString "_") param [2,""];

CHECK(_cordType isEqualTo "" || _camo isEqualTo "");

(_cordType splitString "_") params["_unit",["_cadet",""]];

if ((_cadet isEqualTo "fa") || (_cadet isEqualTo "oa")) then {
    _path = format[QPATHTOF(data\cords\%1\%2\mts_cords_%1_%2_%3_co.paa), _unit, _camo, _cadet];
} else {
    if (_unit isEqualTo "inf") then {
        _path = format["\german_uniforms\tex\pbw_schulterklappen%1_co.paa", _camo];
    } else {
        _path = format[QPATHTOF(data\cords\%1\%2\mts_cords_%1_%2_co.paa), _unit, _camo];
    };
};

player setObjectTextureGlobal [2, _path];
