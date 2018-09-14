/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds an action for the player to place his place his current map on the ground.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_map_fnc_addPlaceMapAction
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

private _placeMapAction = [
    QGVAR(placeMapAction),
    LLSTRING(placeMap),
    "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        if !((toLower (stance player)) isEqualTo "crouch") then {
            player playAction "crouch";
        };
        [{(toLower (stance player)) isEqualTo "crouch"}, {
            player playAction "putdown";
            private _soundFile = format["z\mts_enhanced\addons\map\data\sounds\unfold_map_%1.ogg", ((floor random 4) + 1)];
            playSound3D [_soundFile, player, false, getPosASL player, 10, 1, 15];
        }] call CBA_fnc_waitUntilAndExecute;

        [{(animationState player select [25,7]) isEqualTo "putdown"}, {
            private _pos = player getRelPos [1, 0];
            _pos set [2, ((getposATL player) select 2)];
            private _map = GVAR(itemMapClassname) createVehicle [0,0,0];
            _map setDir ((getDir player) + 90);
            _map setPosATL _pos;

            [_map] remoteExecCall [QFUNC(mapActionMenu), 0, _map];

            player unlinkItem "ItemMap";
        }] call CBA_fnc_waitUntilAndExecute;
    },
    {
        ("ItemMap" in (assignedItems player)) && {[player, objNull] call ace_common_fnc_canInteractWith}
    }
] call ace_interact_menu_fnc_createAction;

[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _placeMapAction] call ace_interact_menu_fnc_addActionToClass;
