#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds ability to destroy the bush infront of the player.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_common_fnc_addBushCutter
 *
 */

CHECK(!hasinterface);

private _action = [
    QGVAR(bushcutter),
    LLSTRING(bushcutter_removeBush),
    QPATHTOF(ui\mts_bushcutter.paa),
    {
        params ["", "_player"];

        private _bush = [_player, BUSH_CUTTING_DISTANCE] call FUNC(seesBush);

        if (isNull _bush) exitWith {WARNING("No bush found. Cannot remove bush.")};

        if ((stance _player) isEqualTo "PRONE") then {
            _player playMove "AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon";
        } else {
            _player playMove "AinvPknlMstpSnonWnonDnon_medic0";
        };

        [GVAR(bushcutter_duration), [_bush], {
            (_this select 0) params ["_bush"];

            // TODO: When Arma v2.12 releases, change to _bush setDamage [1, true, _player, _player]; (server execution)
            _bush setDamage 1;
        }, {}, LLSTRING(bushcutter_removeBush)
        ] call ace_common_fnc_progressBar;
    },
    {
        params ["", "_player"];
        GVAR(bushcutter_enabled) &&
        {!isNull ([_player, BUSH_CUTTING_DISTANCE] call FUNC(seesBush))} &&
        {[_player, objNull] call ace_common_fnc_canInteractWith}
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
