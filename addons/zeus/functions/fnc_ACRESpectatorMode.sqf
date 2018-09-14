/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds Zeus module to toggle ACRE spectator mode.
 *      Adds a hotkey to toggle ACRE spectator mode in Zeus.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_zeus_fnc_ACRESpectatorMode
 *
 */
#include "script_component.hpp"

CHECK(!isClass (configFile >> "CfgPatches" >> "acre_api") || !hasinterface);

//Zeus module
["vLehrBrig16", LLSTRING(acreSpectator),
    {
        private _dialog_result = [
            LLSTRING(acreSpectator),
            [
                [LLSTRING(acreSpectator), [LLSTRING(statusDisable), LLSTRING(statusEnable)], 1]
            ]
        ] call Ares_fnc_showChooseDialog;

        CHECK(_dialog_result isEqualTo []);

        _dialog_result params ["_result"];

        if (_result isEqualTo 1) then {
            [true] call acre_api_fnc_setSpectator;
        } else {
            [false] call acre_api_fnc_setSpectator;
        };
    }
] call Ares_fnc_RegisterCustomModule;

//Hotkey
[
    LLSTRING(cba_keybinding_categoryName),
    QGVAR(acreSpectatorHotkey),
    LLSTRING(acreSpectator_hotkey),
    {
        if (!isNull curatorCamera) then {
            if ([] call acre_api_fnc_isSpectator) then {
                [false] call acre_api_fnc_setSpectator;
                [LLSTRING(acreSpectator_disabled)] call Ares_fnc_ShowZeusMessage;
            } else {
                [true] call acre_api_fnc_setSpectator;
                [LLSTRING(acreSpectator_enabled)] call Ares_fnc_ShowZeusMessage;
            };
        };
    },
    {},
    [0x16,  [false, false, false]], //U
    false
] call CBA_fnc_addKeybind;
