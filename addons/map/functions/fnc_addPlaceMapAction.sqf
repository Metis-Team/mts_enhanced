#include "script_component.hpp"
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

CHECK(!hasinterface);

private _placeMapAction = [
    QGVAR(placeMapAction),
    LLSTRING(placeMap),
    "\A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        params ["", "_player"];

        if ((stance _player) isNotEqualTo "CROUCH") then {
            _player playAction "crouch";
        };

        [{(stance _this) isEqualTo "CROUCH"}, {
            params ["_player"];

            _player playAction "putdown";
            [_player, "unfold"] call FUNC(playMapSound);
        }, _player] call CBA_fnc_waitUntilAndExecute;

        [{((animationState _this) select [25,7]) isEqualTo "putdown"}, {
            params ["_player"];

            private _pos = _player getRelPos [1, 0];
            _pos set [2, (getposATL _player) select 2];

            private _map = GVAR(itemMapClassname) createVehicle [0, 0, 0];
            _map setDir ((getDir _player) + 90);
            _map setPosATL _pos;

            [{
                params ["_player", "_map"];

                private _id = [QGVAR(addMapActions), [_map]] call CBA_fnc_globalEventJIP;
                [_id, _map] call CBA_fnc_removeGlobalEventJIP; // Remove JIP when map is deleted

                private _mapClass = [_player] call FUNC(removeMap);
                _map setVariable [QGVAR(mapClass), _mapClass, true];
            }, [_player, _map]] call CBA_fnc_execNextFrame;
        }, _player] call CBA_fnc_waitUntilAndExecute;
    },
    {
        params ["", "_player"];
        ([_player] call FUNC(hasMap)) && {[_player, objNull] call ace_common_fnc_canInteractWith}
    }
] call ace_interact_menu_fnc_createAction;

[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _placeMapAction] call ace_interact_menu_fnc_addActionToClass;
