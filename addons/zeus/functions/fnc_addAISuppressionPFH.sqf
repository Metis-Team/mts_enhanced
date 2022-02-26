#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds PFH to handle suppression for local units.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [] call mts_zeus_fnc_addAISuppressionPFH
 *
 */

[{
    if (GVAR(suppressedLocalUnits) isEqualTo []) exitWith {
        GVAR(suppressedLocalUnits) = nil;
        (_this select 1) call CBA_fnc_removePerFrameHandler;
    };

    {
        if (!alive _x) then {
            [QGVAR(disableSuppression), [_x]] call CBA_fnc_localEvent;
            continue;
        };

        private _suppressionParams = _x getVariable [QGVAR(suppressionParameters), []];
        if (_suppressedParams isEqualTo []) then {
            continue;
        };
        _suppressionParams params ["_suppressionThreshold", "_suppressedStance", "_originalStance"];

        if (getSuppression _x >= _suppressionThreshold) then {
            if (unitPos _x isNotEqualTo _suppressedStance) then {
                _x setUnitPos _suppressedStance;
            };
        } else {
            if (unitPos _x isNotEqualTo _originalStance) then {
                _x setUnitPos _originalStance;
            };
        };
    } forEach GVAR(suppressedLocalUnits);
}, 1, []] call CBA_fnc_addPerFrameHandler;
