#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds an action for the object to pick it up (delete).
 *      This funtion has a local effect.
 *
 *  Parameter(s):
 *      0: OBJECT - Object on which the action will be placed.
 *      1: STRING - Display name of the object for info and pickup text.(Optional, default: Config display name)
 *      2: CODE - Code executed before the object is deleted. (Optional)
 *      3: ANY - Arguments passed to every custom code. (Optional)
 *      4: STRING - Icon path for ACE pickup action. (Optional, default: Arma take icon)
 *      5: ARRAY - Relative positon of ACE pickup action on the object. (Optional, default: Object center)
 *      6: NUMBER - Max distance player can be from ACE pickup action point. (Optional, default: 2)
 *
 *  Following arguments are passed to the custom code:
 *      0: OBJECT - Object the action is attached to.
 *      1: OBJECT - Player.
 *      2: ANY - Custom arguments given in parameter 3.
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      [_obj, "Flag (green)", {systemChat str _this}, ["green"], nil, [0, -0.45, 1.25]] call mts_items_fnc_pickupItem
 *
 */

params [
    ["_obj", objNull, [objNull]],
    ["_objName", "", [""]],
    ["_userCode", nil, [{}]],
    ["_args", []],
    ["_icon", "A3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa", [""]],
    ["_actionPos", [0, 0, 0], [[]]],
    ["_actionRad", 2, [0]]
];

CHECK(isNull _obj);

// Get display name of object from config
if (_objName isEqualTo "") then {
    _objName = getText (configFile >> "CfgWeapons" >> (typeOf _obj) >> "displayName");
};

private _pickupItem = [
    format [QGVAR(pickupItem%1), GVAR(pickupItemActionCounter)],
    format [LLSTRING(pickupItem), _objName],
    _icon,
    {
        params ["_obj", "", "_ACEargs"];
        _ACEargs params ["_userCode", "_args"];

        player playAction "PutDown";

        [{((animationState player) select [25,7]) isEqualTo "putdown"}, {
            params ["_obj", "_userCode", "_args"];

            // Call custom code
            if !(isNil "_userCode") then {
                [_obj, player, _args] call _userCode;
            };

            // Remove the object
            deleteVehicle _obj;
        }, [_obj, _userCode, _args]] call CBA_fnc_waitUntilAndExecute;
    },
    {true},
    {},
    [_userCode, _args],
    _actionPos,
    _actionRad
] call ace_interact_menu_fnc_createAction;
[_obj, 0, [], _pickupItem] call ace_interact_menu_fnc_addActionToObject;

GVAR(pickupItemActionCounter) = GVAR(pickupItemActionCounter) + 1;
