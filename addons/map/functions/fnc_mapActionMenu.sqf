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
#include "script_component.hpp"
params [["_map", objNull, [objNull]], ["_vehicle", objNull, [objNull]]];

CHECK(isNull _map);

private _openMap = [
    QGVAR(openMap),
    LLSTRING(openMap),
    "A3\Ui_f\data\GUI\Rsc\RscDisplayArsenal\map_ca.paa",
    {
        params ["_map"];

        if ("ItemMap" in (assignedItems player)) then {
            GVAR(hasMap) = true;
        } else {
            GVAR(hasMap) = false;
            player linkItem "ItemMap";
        };

        GVAR(map) = _map;
        openMap true;
    },
    {
        true
    }
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _openMap] call ace_interact_menu_fnc_addActionToObject;

private _pickupMap = [
    QGVAR(pickupMap),
    LLSTRING(pickupMap),
    "A3\Ui_f\data\MAP\Markers\Military\pickup_ca.paa",
    {
        params ["_map", "", "_args"];
        _args params ["_vehicle"];

        playSound3D ["z\mts_enhanced\addons\map\data\sounds\pickup_map.ogg", player, false, getPosASL player, 10, 1, 15];
        player playAction "PutDown";

        [{((animationState player) select [25,7]) isEqualTo "putdown"}, {
            params ["_map", "_vehicle"];

            [QGVAR(removeMap), _map] call CBA_fnc_remoteEvent;

            deleteVehicle _map;

            if (!isNull _vehicle) then {
                _vehicle setVariable [QGVAR(isMapOnVehicle), false, true];
            };

            GVAR(hasMap) = true;
            player linkItem "ItemMap";
        }, [_map, _vehicle]] call CBA_fnc_waitUntilAndExecute;
    },
    {
        !("ItemMap" in (assignedItems player))
    },
    {},
    [_vehicle]
] call ace_interact_menu_fnc_createAction;
[_map, 0, ["ACE_MainActions"], _pickupMap] call ace_interact_menu_fnc_addActionToObject;
