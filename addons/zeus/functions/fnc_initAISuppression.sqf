#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Initializes AI suppression behaviour. This behaviour is handled on every machine on which local units exists.
 *      E.g. Server and zeus have placed AI units -> Units behaviour will behandled where unit is local, so all units of the server on the server, etc.
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

[QGVAR(enableSuppression), {
    params ["_unit", "_suppressionThreshold", "_suppressedStance"];

    CHECK(isNull _unit || !local _unit || _unit getVariable [ARR_2(QGVAR(suppressionEnabled), false)]);
    CHECK(_suppressionThreshold < 0 || _suppressionThreshold > 1);
    _suppressedStance = toUpper _suppressedStance;
    CHECK(!(_suppressedStance in ["DOWN", "MIDDLE", "UP"]));

    if (isNil QGVAR(suppressedLocalUnits)) then {
        GVAR(suppressedLocalUnits) = [];
        [] call FUNC(addAISuppressionPFH);
    };

    private _originalStance = GVAR(stanceMapping) getOrDefault [stance _unit, "UP"];

    GVAR(suppressedLocalUnits) pushBackUnique [_unit, _suppressionThreshold, _suppressedStance, _originalStance];

    _unit setVariable [QGVAR(suppressionEnabled), true, true];
}] call CBA_fnc_addEventHandler;

[QGVAR(disableSuppression), {
    params ["_unit"];

    CHECK(isNull _unit || !local _unit || !(_unit getVariable [ARR_2(QGVAR(suppressionEnabled), false)]));

    private _index = GVAR(suppressedLocalUnits) findIf {(_x select 0) isEqualTo _unit};
    // Unit wasn't suppressed before
    CHECK(_index < 0);
    GVAR(suppressedLocalUnits) deleteAt _index;
}] call CBA_fnc_addEventHandler;

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
                    ["COMBO", [LLSTRING(suppression_stance), LLSTRING(suppression_stance_tooltip)], [["DOWN", "MIDDLE", "UP"], [localize "str_3den_attributes_stance_down", localize "str_3den_attributes_stance_middle", localize "str_3den_attributes_stance_up"], 0]]
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

               [QGVAR(disableSuppression), [_x], _x] call CBA_fnc_targetEvent;
           } forEach _objects;
        },
        {
           params ["", "_objects"];

           ({_x getVariable [QGVAR(suppressionEnabled), false]} count _objects) > 0
        }
    ] call zen_context_menu_fnc_createAction;
    [_disableSuppressionAction, [], 0] call zen_context_menu_fnc_addAction;
};
