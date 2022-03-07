#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Function called when 3DEN save event was triggered.
 *      Handles saving comments into scenario space for later use.
 *
 *  Parameter(s):
 *      0: BOOLEAN - Function was triggered by autosave; else manual save.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [false] call mts_enhanced_fnc_on3DENMissionSave
 *
 */

params ["_isAutosave"];

CHECK(!is3DEN);

TRACE_1("3DEN Mission saved", _isAutosave);

private _3denComments = [];
{
    if (_x isEqualTo -999) then {
        continue;
    };

    private _name = (_x get3DENAttribute "name") select 0;
    private _description = (_x get3DENAttribute "description") select 0;
    private _positionASL = (_x get3DENAttribute "position") select 0;

    _3denComments pushBack [_x, _name, _description, _positionASL];
} forEach (all3DENEntities param [7, []]);

TRACE_1("Saving comments", _3denComments);

set3DENMissionAttributes [["Scenario", QGVAR(3denComments), _3denComments]];
