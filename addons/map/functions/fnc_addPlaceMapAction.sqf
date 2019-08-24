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
        params ["", "_player"];

        if !((toLower (stance _player)) isEqualTo "crouch") then {
            _player playAction "crouch";
        };

        [{(toLower (stance (_this select 0))) isEqualTo "crouch"}, {
            params ["_player"];

            _player playAction "putdown";
            private _soundFile = format ["z\mts_enhanced\addons\map\data\sounds\unfold_map_%1.ogg", ((floor random 4) + 1)];
            playSound3D [_soundFile, _player, false, getPosASL _player, 10, 1, 15];
        }, [_player]] call CBA_fnc_waitUntilAndExecute;

        [{((animationState (_this select 0)) select [25,7]) isEqualTo "putdown"}, {
            params ["_player"];

            private _pos = _player getRelPos [1, 0];
            _pos set [2, ((getposATL _player) select 2)];
            private _map = GVAR(itemMapClassname) createVehicle [0,0,0];
            _map setDir ((getDir _player) + 90);
            _map setPosATL _pos;

            [_map] remoteExecCall [QFUNC(mapActionMenu), 0, _map];

            _player unlinkItem "ItemMap";
        }, [_player]] call CBA_fnc_waitUntilAndExecute;
    },
    {
        params ["", "_player"];
        ("ItemMap" in (assignedItems _player)) && {[_player, objNull] call ace_common_fnc_canInteractWith}
    }
] call ace_interact_menu_fnc_createAction;

[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _placeMapAction] call ace_interact_menu_fnc_addActionToClass;
