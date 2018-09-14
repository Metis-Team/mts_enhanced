/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds a zeus module which shows the zeus what the AI knows about the target.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_moduleTargetKnowledge
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

["vLehrBrig16", LLSTRING(AI_targetKnowledge), {
    params["", ["_AI", objNull, [objNull]]];

    //Check if selected unit is an AI
    if ((isPlayer _AI) || {isnull _AI}) exitWith {
        [LLSTRING(AI_noAI)] call Ares_fnc_ShowZeusMessage;
    };

    //Draw line and icon from AI to mouse
    [_AI, {
        params ["_successful", "_AI"];

        CHECK(!(_successful && {alive _AI}));

        //get cursor info
        curatorMouseOver params ["_typeName", "_target"];

        //make sure cursor object is an AI or a player
        if (!(_typeName isEqualTo "OBJECT") || {(count (crew _target)) isEqualTo 0} || {isnull _target}) exitWith {
            [LLSTRING(AI_noTarget)] call Ares_fnc_ShowZeusMessage;
        };

        //get info
        private _info = _AI targetKnowledge _target;
        _info params ["_knownByGroup", "_knownByUnit"];

        //give the curator the info
        [LLSTRING(AI_addedInfo)] call Ares_fnc_ShowZeusMessage;

        systemChat format ["1. %1: %2.", LLSTRING(AI_knownByGroup), localize format [LSTRING(AI_%1), _knownByGroup]];
        systemChat format ["2. %1: %2.", LLSTRING(AI_knownByUnit), localize format [LSTRING(AI_%1), _knownByUnit]];

    }, LLSTRING(AI_targetKnowledge), "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa", [1, 0, 0, 1], 45] call ace_zeus_fnc_getModuleDestination;
}] call Ares_fnc_RegisterCustomModule;
