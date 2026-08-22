#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds Zeus module for removing all smoke grenades from units of a side.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_zeus_fnc_moduleRemoveSmokeGrenades
 *
 */

[LELSTRING(main,category), LLSTRING(removeSmokeGrenades),
    {
        // open UI
        [
            LLSTRING(removeSmokeGrenades),
            [
                ["SIDES", [localize "STR_ZEN_Common_Side", LLSTRING(removeSmokeGrenades_side_tooltip)], east]
            ],
            {
                (_this select 0) params ["_side"];
                TRACE_1("Dialog data",_this select 0);

                {
                    private _unit = _x;
                    private _smokeMags = (throwables _unit) apply {_x select 0} select {_x in GVAR(grenadesSmoke)};
                    _smokeMags = _smokeMags arrayIntersect _smokeMags;
                    _smokeMags apply {_unit removeMagazineGlobal _x};
                } forEach units _side;
            }
        ] call zen_dialog_fnc_create;
    },
    "x\zen\addons\context_actions\ui\grenade_ca.paa"
] call zen_custom_modules_fnc_register;
