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
    {
        _x params ["_unit", "_suppressionThreshold", "_suppressedStance", "_originalStance"];

        if (getSuppression _unit >= _suppressionThreshold) then {
            if (unitPos _unit isNotEqualTo _suppressedStance) then {
                _unit setUnitPos _suppressedStance;
            };
        } else {
            if (unitPos _unit isNotEqualTo _originalStance) then {
                _unit setUnitPos _originalStance;
            };
        };
    } count GVAR(suppressedLocalUnits);
}, 0.5, []] call CBA_fnc_addPerFrameHandler;
