/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds zeus module to show the projectiles of a selected unit for a set duration.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_zeus_fnc_moduleShowProjectiles
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

["vLehrBrig16", LLSTRING(showProjectiles),
    {
        private _dialog_result = [
            LLSTRING(showProjectiles),
            [
                [LLSTRING(showProjectiles_duration), "", "10"]
            ]
        ] call Ares_fnc_showChooseDialog;

    CHECK(_dialog_result isEqualTo []);

    params ["", ["_unit", objNull, [objNull]]];

    _dialog_result params ["_result"];
    private _duration = parseNumber _result;

    if (isNull _unit) exitWith {
        [LLSTRING(showProjectiles_errorNoUnit)] call Ares_fnc_ShowZeusMessage;
    };
    if (_duration > 600) exitWith {
        [LLSTRING(showProjectiles_errorMaxDuration)] call Ares_fnc_ShowZeusMessage;
    };

    [_unit] call CBA_fnc_addUnitTrackProjectiles;
    sleep _duration;
    [_unit] call CBA_fnc_removeUnitTrackProjectiles;

    }
] call Ares_fnc_RegisterCustomModule;
