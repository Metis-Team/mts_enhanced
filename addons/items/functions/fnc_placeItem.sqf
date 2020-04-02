/**
 *  Author: Timi007
 *
 *  Description:
 *      Creates an object of given classname and makes it placable for the player.
 *
 *  Parameter(s):
 *      0: STRING - Classname of object which should be placed.
 *      1: STRING - Display name of the object for info and pickup text.(Optional, default: Config display name)
 *      2: CODE - Code executed before the placing but after the creation of the local object. (Optional)
 *      3: CODE - Code executed after the placing is approved and the global object is created but before object is moved. (Optional)
 *      4: CODE - Code executed if ACE pickup action is executed. (Optional)
 *      5: ANY - Arguments passed to every custom code. (Optional)
 *      6: NUMBER - Object start placing height (Optional, default -0.5)
 *      7: STRING - Icon path for ACE pickup action. (Optional, default: Arma take icon)
 *      8: ARRAY - Relative positon of ACE pickup action on the object. (Optional, default: Object center)
 *      9: NUMBER - Max distance player can be from ACE pickup action point. (Optional, default: 2)
 *
 *  Following arguments are passed to every custom code (param 2, 3, 4):
 *      0: OBJECT - Local (for param 2) or global (for param 3, 4) object created.
 *      1: OBJECT - Player.
 *      2: ANY - Custom arguments given in parameter 5.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["FlagChecked_F", {systemChat str _this}, {}, {}, ["green"]] call mts_items_fnc_placeItem
 *
 */
#include "script_component.hpp"

params [
    ["_classname", "", [""]],
    ["_objName", "", [""]],
    ["_beforeCode", nil, [{}]],
    ["_afterCode", nil, [{}]],
    ["_pickupCode", nil, [{}]],
    ["_args", []],
    ["_startHeight", MIN_HEIGHT, [0]],
    ["_pickupIcon", "A3\Ui_f\data\IGUI\Cfg\Actions\take_ca.paa", [""]],
    ["_pickupAcPos", [0, 0, 0], [[]]],
    ["_pickupAcRad", 2, [0]]
];

CHECK(_classname isEqualTo "");

// Create local object
private _obj = _classname createVehicleLocal [0, 0, 0];
_obj disableCollisionWith player;

// Set object start height
GVAR(objectHeight) = _startHeight;

// Call custom code
if !(isNil "_beforeCode") then {
    [_obj, player, _args] call _beforeCode;
};

GVAR(isPlacing) = PLACE_WAITING;

// Get display name of object from config
if (_objName isEqualTo "") then {
    _objName = getText (configFile >> "CfgWeapons" >> (typeOf _obj) >> "displayName");
};

// Add info dialog for the player which show the controls
private _placeItemText = format [LLSTRING(placeItem), _objName];
[_placeItemText, LLSTRING(cancel), LLSTRING(adjustHeight)] call ace_interaction_fnc_showMouseHint;

private _mouseClickID = [player, "DefaultAction", {GVAR(isPlacing) isEqualTo PLACE_WAITING}, {GVAR(isPlacing) = PLACE_APPROVE}] call ace_common_fnc_addActionEventHandler;

// Leave index 0 free for global object
private _pickupArgs = [objNull, _objName, _pickupCode, _args, _pickupIcon, _pickupAcPos, _pickupAcRad];

[{
    params ["_PFHArgs", "_PFHID"];
    _PFHArgs params ["_obj", "_classname", "_afterCode", "_mouseClickID", "_pickupArgs"];

    if ((isNull _obj) || {!([player, _obj] call ace_common_fnc_canInteractWith)}) then {
        GVAR(isPlacing) = PLACE_CANCEL;
    };

    if !(GVAR(isPlacing) isEqualTo PLACE_WAITING) exitWith {
        [_PFHID] call CBA_fnc_removePerFrameHandler;
        call ace_interaction_fnc_hideMouseHint;
        [player, "DefaultAction", _mouseClickID] call ace_common_removeActionEventHandler;

        if (GVAR(isPlacing) isEqualTo PLACE_APPROVE) then {
            GVAR(isPlacing) = PLACE_CANCEL;

            // End position of the object
            player playAction "putdown";

            [{(animationState player select [25, 7]) isEqualTo "putdown"}, {
                params ["_obj", "_classname", "_afterCode", "_pickupArgs"];

                // Save positon and direction
                private _posObj = getPosWorld _obj;
                private _dirObj = getDir _obj;
                deleteVehicle _obj;

                private _globalObj = _classname createVehicle [0, 0, 0];

                // Call custom code
                if !(isNil "_afterCode") then {
                    private _args = _pickupArgs select 3;
                    [_globalObj, player, _args] call _afterCode;
                };

                // Apply same positon and direction as local object
                _globalObj setPosWorld _posObj;
                _globalObj setDir _dirObj;

                // Add ACE pickup action
                _pickupArgs set [0, _globalObj];
                _pickupArgs remoteExecCall [QFUNC(pickupItem), 0, _globalObj];
            }, [_obj, _classname, _afterCode, _pickupArgs]] call CBA_fnc_waitUntilAndExecute;
        } else {
            // Action is canceled
            deleteVehicle _obj;
        };
    };

    // Alternativ to "player getRelPos [MAX_DISTANCE, 0]" because flag wasn't in the center of the view
    private _pos = ((eyePos player) vectorAdd ((getCameraViewDirection player) vectorMultiply MAX_DISTANCE));
    // Adjust height of flag with the scroll wheel
    _pos set [2, ((getPosWorld player) select 2) + GVAR(objectHeight)];

    _obj setPosWorld _pos;
    _obj setDir (getDir player);
}, 0, [_obj, _classname, _afterCode, _mouseClickID, _pickupArgs]] call CBA_fnc_addPerFrameHandler;
