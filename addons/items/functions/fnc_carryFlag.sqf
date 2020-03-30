/**
 *  Author: Timi007
 *
 *  Description:
 *      Attaches colored flag to the back of the player and removes his flag item.
 *
 *  Parameter(s):
 *      0: STRING - Color of the flag.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["red"] call mts_items_fnc_carryFlag
 *
 */
#include "script_component.hpp"

params [["_color", "", [""]]];

_color = toLower _color;

if (_color in ["red", "blue", "green", "yellow"]) then {
    //arma need a flag proxy & some modded uniforms don't have them so we use a trick
    private _loadout = getUnitLoadout player;
    player forceAddUniform "U_B_CombatUniform_mcam";

    if (_color isEqualTo "yellow") then {
        player forceFlagTexture QPATHTOF(data\Flag_yellow_co.paa);
    } else {
        player forceFlagTexture format ["\A3\Data_F\Flags\Flag_%1_co.paa", _color];
    };

    //execute it in the next frame otherwise it will not work
    [{
        params ["_loadout", "_color"];

        player setUnitLoadout _loadout;
        player removeItem format [QGVAR(%1), _color];
    }, [_loadout, _color]] call CBA_fnc_execNextFrame;
} else {
    //remove carried flag
    private _flagTexture = getForcedFlagTexture player;
    if !(_flagTexture isEqualTo "") then {
        player forceFlagTexture "";
        private _flagColorPath = _flagTexture splitString "_";
        reverse _flagColorPath;
        private _flagColor = _flagColorPath select 1;
        player addItem format [QGVAR(%1), _flagColor];
    };
};
