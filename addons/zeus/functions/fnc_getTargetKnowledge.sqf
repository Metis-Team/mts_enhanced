#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Shows the knowledge the given unit has about a selected target by zeus.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit which should be queried.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit] call mts_zeus_fnc_getTargetKnowledge
 *
 */

params ["_unit"];

TRACE_1("getTargetKnowledge called",_this);

//Check if selected unit is an AI
if ((isPlayer _unit) || {isNull _unit}) exitWith {
    [LLSTRING(AI_noAI)] call zen_common_fnc_showMessage;
};

//Draw line and icon from AI to mouse
[getPosASL _unit, {
    params ["_successful", "", "", "", "", "", "_args"];
    _args params ["_unit"];

    CHECK(!(_successful && {alive _unit}));

    //get cursor info
    curatorMouseOver params ["_typeName", "_target"];

    //make sure cursor object is an AI or a player
    if (!(_typeName isEqualTo "OBJECT") || {(count (crew _target)) isEqualTo 0} || {isNull _target}) exitWith {
        [LLSTRING(AI_noTarget)] call zen_common_fnc_showMessage;
    };

    //get info
    private _info = _unit targetKnowledge _target;
    _info params ["_knownByGroup", "_knownByUnit"];

    //give the curator the info
    [LLSTRING(AI_addedInfo)] call zen_common_fnc_showMessage;

    systemChat format ["1. %1: %2.", LLSTRING(AI_knownByGroup), localize format [LSTRING(AI_%1), _knownByGroup]];
    systemChat format ["2. %1: %2.", LLSTRING(AI_knownByUnit), localize format [LSTRING(AI_%1), _knownByUnit]];
}, [_unit], LLSTRING(AI_targetKnowledge)] call FUNC(getModuleDestination);
