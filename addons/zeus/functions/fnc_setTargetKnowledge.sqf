#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Ask the zeus to select the target which should be revealed to or forgotten by the passed units.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit to reveal or which should forget the target.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["REVEAL", [_unit]] call mts_zeus_fnc_setTargetKnowledge
 *
 */

params [["_type", "REVEAL", [""]], ["_units", [], [[]]]];

if (_units isEqualTo [] || isNull (_units select 0)) exitWith {
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

    // Check if all selected units are AI
    if ((count _units) isNotEqualTo ({_x isKindOf "man" && !isPlayer _x} count _units)) exitWith {
        [LLSTRING(AI_noAI)] call zen_common_fnc_showMessage;
    };

    {
        if (_doReveal) then {
            _x reveal _target;
        } else {
            _x forgetTarget _target;
        };
    } forEach _units;

    // Give the curator feedback
    if (_doReveal) then {
        [LLSTRING(AI_revealedInfo)] call zen_common_fnc_showMessage;
    } else {
        [LLSTRING(AI_forgotInfo)] call zen_common_fnc_showMessage;
    };
}, [_doReveal, _units], _iconText, nil, nil, nil, _drawLine] call FUNC(getModuleDestination);
