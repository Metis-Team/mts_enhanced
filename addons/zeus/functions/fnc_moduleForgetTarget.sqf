/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds a zeus module which lets an AI forget about an unit.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_moduleForgetTarget
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

["vLehrBrig16", LLSTRING(AI_forgetTarget), {
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

        //let the first selected AI forget about our second selected unit
        _AI forgetTarget _target;

        //give the curator feedback
        [LLSTRING(AI_forgotInfo)] call Ares_fnc_ShowZeusMessage;
    }, LLSTRING(AI_forgetTarget), "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa", [1, 0, 0, 1], 45] call ace_zeus_fnc_getModuleDestination;
}] call Ares_fnc_RegisterCustomModule;
