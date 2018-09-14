/**
 *  Author: PhILoX
 *
 *  Description:
 *      Adds the deescalationrabbit to the ACE interaction menu for our glorious 323 leader.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_common_fnc_addDeescalationrabbit
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface || !((getPlayerUID player) isEqualTo "76561198014168529"));

private _action = [
    QGVAR(deescalationrabbit),
    "Deeskalationshase",
    "",
    {
        player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
        [{
            params ["_player"];
            private _rabbit = createAgent ["Rabbit_F", [0,0,0], [], 0, "NONE"];
            _rabbit setPos (_player modelToWorld [0, 1.5, 0]);
        }, player, 0.6] call CBA_fnc_waitAndExecute;
    },
    {true}
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions"], _action] call ace_interact_menu_fnc_addActionToClass;
