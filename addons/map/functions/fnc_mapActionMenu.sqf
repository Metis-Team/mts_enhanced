#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds the pickup & open map actions to the placed map.
 *      This function has a local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Placed map
 *      1: OBJECT - The vehicle which the map is placed on. (Optional, only needed if actions are called from vehicle interaction)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_map] call mts_map_fnc_mapActionsMenu
 *
 */

params [["_map", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];

CHECK(isNull _map);

private _openMap = [
    QGVAR(openMap),
    LLSTRING(openMap),
    "A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        params ["_map", "_player"];

        if ("ItemMap" in (assignedItems _player)) then {
            GVAR(hasMap) = true;
        } else {
            GVAR(hasMap) = false;
            _player linkItem "ItemMap";
        };

        GVAR(map) = _map;
        openMap true;
    },
    {
        params ["_map", "_player"];
        [_player, _map] call ace_common_fnc_canInteractWith
    }
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _openMap] call ace_interact_menu_fnc_addActionToObject;

private _pickupMap = [
    QGVAR(pickupMap),
    LLSTRING(pickupMap),
    "A3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa",
    {
        params ["_map", "_player", "_args"];
        _args params ["_vehicle"];

        playSound3D ["z\mts_enhanced\addons\map\data\sounds\pickup_map.ogg", _player, false, getPosASL _player, 10, 1, 15];
        _player playAction "PutDown";

        [{((animationState (_this select 1)) select [25,7]) isEqualTo "putdown"}, {
            params ["_map", "_player", "_vehicle"];

            [QGVAR(removeMap), _map] call CBA_fnc_remoteEvent;

            deleteVehicle _map;

            if (!isNull _vehicle) then {
                _vehicle setVariable [QGVAR(isMapOnVehicle), false, true];
            };

            GVAR(hasMap) = true;
            _player linkItem "ItemMap";
        }, [_map, _player, _vehicle]] call CBA_fnc_waitUntilAndExecute;
    },
    {
        params ["_map", "_player"];
        !("ItemMap" in (assignedItems _player)) && {[_player, _map] call ace_common_fnc_canInteractWith}
    },
    {},
    [_vehicle]
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _pickupMap] call ace_interact_menu_fnc_addActionToObject;
