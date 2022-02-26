#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Initializes AI suppression behaviour. This behaviour is handled on every machine on which local units exists.
 *      E.g. Server and zeus have placed AI units -> Units behaviour will be handled where unit is local, so all units of the server on the server, etc.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [] call mts_zeus_fnc_initAISuppression
 *
 */

GVAR(stanceMapping) = createHashMapFromArray [["PRONE", "DOWN"], ["CROUCH", "MIDDLE"], ["STAND", "UP"]];

[QGVAR(enableSuppression), LINKFUNC(enableSuppression)] call CBA_fnc_addEventHandler;
[QGVAR(disableSuppression), LINKFUNC(disableSuppression)] call CBA_fnc_addEventHandler;

player addEventHandler ["Local", {
    params ["_unit", "_isLocal"];

    CHECK(isNull _unit);
    CHECK(!(_unit getVariable [ARR_2(QGVAR(suppressionEnabled), false)]));

    // transfer unit ownership
    if (_isLocal) then {
        // Add to new owner
        [_unit] call FUNC(addSuppressedLocalUnit);
    } else {
        // Remove unit from old Owner
        [_unit] call FUNC(removeSuppressedLocalUnit);
    };
}];

if (hasInterface) then {
    private _enableSuppressionAction = [
        QGVAR(enableSuppression),
        LLSTRING(suppression_enable),
        "",
        {
           params ["", "_objects"];

            [
                LLSTRING(suppression_enable),
                [
                    ["SLIDER", [LLSTRING(suppression_threshold), LLSTRING(suppression_threshold_tooltip)], [0, 1, 0.5, 2]],
                    ["COMBO", ["STR_A3_RscAttributeUnitPos_Title", LLSTRING(suppression_stance_tooltip)],
                        [
                            ["DOWN", "MIDDLE", "UP"],
                            [
                                ["STR_A3_RscAttributeUnitPos_Down_tooltip", "", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_prone_ca.paa"],
                                ["STR_A3_RscAttributeUnitPos_Crouch_tooltip", "", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_crouch_ca.paa"],
                                ["STR_A3_RscAttributeUnitPos_Up_tooltip", "", "\a3\Ui_f\data\IGUI\RscIngameUI\RscUnitInfo\SI_stand_ca.paa"]
                            ],
                            0
                        ]
                    ]
                ],
                {
                    (_this select 0) params ["_suppressionThreshold", "_suppressedStance"];
                    (_this select 1) params ["", "_objects"];

                    {
                        if (!(_x isKindOf "CAManBase") || _x getVariable [QGVAR(suppressionEnabled), false] || isPlayer _x) then {
                            continue;
                        };

                        [QGVAR(enableSuppression), [_x, _suppressionThreshold, _suppressedStance], _x] call CBA_fnc_targetEvent;
                    } forEach _objects;

                    [LLSTRING(suppression_enabled)] call zen_common_fnc_showMessage;
                },
                {},
                _this
            ] call zen_dialog_fnc_create;
        },
        {
           params ["", "_objects"];

           ({_x isKindOf "CAManBase" && !(_x getVariable [QGVAR(suppressionEnabled), false]) && !isPlayer _x} count _objects) > 0
        }
    ] call zen_context_menu_fnc_createAction;
    [_enableSuppressionAction, [], 0] call zen_context_menu_fnc_addAction;

    private _disableSuppressionAction = [
        QGVAR(disableSuppression),
        LLSTRING(suppression_disable),
        "",
        {
           params ["", "_objects"];

           {
               if (!(_x getVariable [QGVAR(suppressionEnabled), false])) then {
                   continue;
               };

               _x setVariable [QGVAR(suppressionEnabled), false, true];
           } forEach _objects;
        },
        {
           params ["", "_objects"];

           ({_x getVariable [QGVAR(suppressionEnabled), false]} count _objects) > 0
        }
    ] call zen_context_menu_fnc_createAction;
    [_disableSuppressionAction, [], 0] call zen_context_menu_fnc_addAction;
};
