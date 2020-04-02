/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds a zeus module which lets an unit get revealed to an AI.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_moduleRevealTarget
 *
 */
#include "script_component.hpp"

["Metis", LLSTRING(AI_revealTarget), {
    params["", ["_AI", objNull, [objNull]]];

    //Check if selected unit is an AI
    if ((isPlayer _AI) || {isnull _AI}) exitWith {
        [LLSTRING(AI_noAI)] call zen_common_fnc_showMessage;
    };

    //Draw line and icon from AI to mouse
    [_AI, {
        params ["_successful", "_AI"];

        CHECK(!(_successful && {alive _AI}));

        //get cursor info
        curatorMouseOver params ["_typeName", "_target"];

        //make sure cursor object is an AI or a player
        if (!(_typeName isEqualTo "OBJECT") || {(count (crew _target)) isEqualTo 0} || {isnull _target}) exitWith {
            [LLSTRING(AI_noTarget)] call zen_common_fnc_showMessage;
        };

        //reveal the second selected unit forget to the first selected AI
        _AI reveal _target;

        //give the curator feedback
        [LLSTRING(AI_revealedInfo)] call zen_common_fnc_showMessage;
    }, LLSTRING(AI_revealTarget), "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa", [1, 0, 0, 1], 45] call ace_zeus_fnc_getModuleDestination;
}] call zen_custom_modules_fnc_register;
