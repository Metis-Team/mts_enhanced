/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds an action for the flag to pick it up and adds the flag item afterwards.
 *      This funtion has a local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Flag.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_flag] call mts_flagmarker_fnc_pickupFlag
 *
 */
#include "script_component.hpp"

params [["_flag", objNull, [objNull]]];

CHECK(isNull _flag);

private _pickupFlag = [
    QGVAR(pickupFlag),
    LLSTRING(pickupFlag),
    QPATHTOF(data\ui\mts_flag_pickup_icon.paa),
    {
        params ["_flag"];

        player playAction "PutDown";

        [{((animationState player) select [25,7]) isEqualTo "putdown"}, {
            params ["_flag"];

            //get the color of the flag
            private _flagTexture = flagTexture _flag;
            private _flagColorPath = _flagTexture splitString "_";
            reverse _flagColorPath;
            private _flagColor = _flagColorPath select 1;

            //add the flag item with the right color to the player
            player addItem format ["MTS_Flag_%1", _flagColor];

            //remove the flag
            deleteVehicle _flag;
        }, [_flag]] call CBA_fnc_waitUntilAndExecute;
    },
    {true},
    {},
    [],
    {[0, -0.45, 1.25]},
    2
] call ace_interact_menu_fnc_createAction;
[_flag, 0, [], _pickupFlag] call ace_interact_menu_fnc_addActionToObject;
