#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds "Make into suicide drone" as modules and to the context menu.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_moduleSuicideDrone
 *
 */

[
    LELSTRING(main,category), LLSTRING(suicideDrone),
    {
        params ["", ["_unit", objNull, [objNull]]];

        if (isNull _unit) exitWith {
            [LLSTRING(suicideDrone_noObject)] call zen_common_fnc_showMessage;
        };

        if (!unitIsUAV _unit || {!alive _unit} || {!isNull objectParent _unit}) exitWith {
            [LLSTRING(suicideDrone_notADrone)] call zen_common_fnc_showMessage;
        };

        if (_unit getVariable [QGVAR(isSuicideDrone), false]) exitWith {
            [LLSTRING(suicideDrone_isAlreadySuicideDrone)] call zen_common_fnc_showMessage;
        };

        GVAR(chargeCache) params ["_configNames", "_displayNames"];

        [
            LLSTRING(suicideDrone),
            [
                ["COMBO", LLSTRING(suicideDrone_charge), [_configNames, _displayNames, 0]]
            ],
            {
                params ["_dialogData", "_unit"];
                _dialogData params ["_chargeType"];

                [_unit, _chargeType] remoteExecCall [QFUNC(makeIntoSuicideDrone), _unit];

                [LLSTRING(suicideDrone_success)] call zen_common_fnc_showMessage;
            },
            {},
            _unit
        ] call zen_dialog_fnc_create;
    },
    "a3\drones_f\air_f_gamma\uav_01\data\ui\uav_01_ca.paa"
] call zen_custom_modules_fnc_register;

private _suicideDroneAction = [
    QGVAR(suicideDrone),
    LLSTRING(suicideDrone),
    "a3\drones_f\air_f_gamma\uav_01\data\ui\uav_01_ca.paa",
    {
        params ["", "_objects"];

        GVAR(chargeCache) params ["_configNames", "_displayNames"];

        [
            LLSTRING(suicideDrone),
            [
                ["COMBO", LLSTRING(suicideDrone_charge), [_configNames, _displayNames, 0]]
            ],
            {
                params ["_dialogData", "_objects"];
                _dialogData params ["_chargeType"];

                {
                    if (!unitIsUAV _unit || {!isNull objectParent _unit}) then {
                        continue;
                    };

                    [_x, _chargeType] remoteExecCall [QFUNC(makeIntoSuicideDrone), _x];
                } forEach _objects;

                [LLSTRING(suicideDrone_success)] call zen_common_fnc_showMessage;
            },
            {},
            _objects
        ] call zen_dialog_fnc_create;
    },
    {
        params ["", "_objects"];
        ({unitIsUAV _x && {!(_x getVariable [QGVAR(isSuicideDrone), false])} && {alive _x} && {isNull objectParent _x}} count _objects) > 0
    }
] call zen_context_menu_fnc_createAction;
[_suicideDroneAction, [], 0] call zen_context_menu_fnc_addAction;

