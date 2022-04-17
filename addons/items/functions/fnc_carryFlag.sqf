#include "script_component.hpp"
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

params [["_color", "", [""]]];

_color = toLower _color;

if (_color in ["red", "blue", "green", "yellow"]) then {
    //arma need a flag proxy & some modded uniforms don't have them so we use a trick
    private _loadout = getUnitLoadout ACE_player;
    ACE_player forceAddUniform "U_B_CombatUniform_mcam";

    if (_color isEqualTo "yellow") then {
        ACE_player forceFlagTexture QPATHTOF(data\Flag_yellow_co.paa);
    } else {
        ACE_player forceFlagTexture format ["\A3\Data_F\Flags\Flag_%1_co.paa", _color];
    };

    //execute it in the next frame otherwise it will not work
    [{
        params ["_loadout", "_color"];

        ACE_player setUnitLoadout _loadout;
        ACE_player removeItem format [QGVAR(%1), _color];
    }, [_loadout, _color]] call CBA_fnc_execNextFrame;
} else {
    //remove carried flag
    private _flagTexture = getForcedFlagTexture ACE_player;
    if !(_flagTexture isEqualTo "") then {
        ACE_player forceFlagTexture "";
        private _flagColorPath = _flagTexture splitString "_";
        reverse _flagColorPath;
        private _flagColor = _flagColorPath select 1;
        ACE_player addItem format [QGVAR(%1), _flagColor];
    };
};
