#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Ask the zeus to select the target which should be revealed to or forgotten by the passed units.
 *
 *  Parameter(s):
 *      0: STRING - Action to do:
 *          REVEAL: Reveal selected target to selected units.
 *          FORGET: Let the selected units forget about the selected target.
 *      1: ARRAY - The selected units. If vehicles is included, the crew is considered.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["REVEAL", [_unit]] call mts_zeus_fnc_setTargetKnowledge
 *
 */

params [["_type", "REVEAL", [""]], ["_selectedUnits", [], [[]]]];

TRACE_1("setTargetKnowledge called",_this);

private _allUnits = flatten (_selectedUnits apply {crew _x});
private _units = _allUnits arrayIntersect _allUnits; // Remove duplicate units

TRACE_1("",_units);

if (_units isEqualTo []) exitWith {
    [LLSTRING(AI_noAI)] call zen_common_fnc_showMessage;
};

_type = toUpper _type;
if (_type isNotEqualTo "REVEAL" && _type isNotEqualTo "FORGET") exitWith {
    ERROR("_type must be 'REVEAL' or 'FORGET'!");
};

private _doReveal = _type isEqualTo "REVEAL";

private _pos = getPosASL (_units select 0);
private _iconText = if (_doReveal) then {LLSTRING(AI_revealTarget)} else {LLSTRING(AI_forgetTarget)};
private _drawLine = (count _units) isEqualTo 1;

// Draw selection indicator
[_pos, {
    params ["_successful", "", "", "", "", "", "_args"];
    _args params ["_doReveal", "_units"];

    CHECK(!_successful);

    // Get selected target
    curatorMouseOver params ["_typeName", "_target"];

    // Make sure target is an AI or a player
    if (!(_typeName isEqualTo "OBJECT") || {(count (crew _target)) isEqualTo 0} || {isnull _target}) exitWith {
        [LLSTRING(AI_noTarget)] call zen_common_fnc_showMessage;
    };

    if (_doReveal) then {
        [QGVAR(revealTarget), [_units, _target]] call CBA_fnc_globalEvent;
        [LLSTRING(AI_revealedInfo)] call zen_common_fnc_showMessage;
    } else {
        [QGVAR(forgetTarget), [_units, _target]] call CBA_fnc_globalEvent;
        [LLSTRING(AI_forgotInfo)] call zen_common_fnc_showMessage;
    };
}, [_doReveal, _units], _iconText, nil, nil, nil, _drawLine] call FUNC(getModuleDestination);
