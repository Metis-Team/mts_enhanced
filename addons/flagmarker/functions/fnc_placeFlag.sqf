/**
 *  Author: Timi007
 *
 *  Description:
 *      Places flag.
 *
 *  Parameter(s):
 *      0: STRING - Color of the flag.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      ["red"] call mts_flagmarker_fnc_placeFlag
 *
 */
#include "script_component.hpp"

params [["_color", "", [""]]];

CHECK(_color isEqualTo "");

//create flag object
private _flag = "FlagChecked_F" createVehicleLocal [0, 0, 0];
_flag disableCollisionWith player;

//set object start height
GVAR(objectHeight) = MIN_HEIGHT;

//check color & set flag color
_color = toLower _color;
if (!(_color in ["red", "blue", "green", "yellow"])) exitWith {};

if (_color isEqualTo "yellow") then {
    _flag setFlagTexture QPATHTOF(data\Flag_yellow_co.paa);
} else {
    _flag setFlagTexture format ["\A3\Data_F\Flags\Flag_%1_co.paa", _color];
};

GVAR(isPlacing) = PLACE_WAITING;

//add info dialog for the player which show the controls
private _placeFlagText = format [LLSTRING(placeFlag), localize format [LSTRING(%1), _color]];
[_placeFlagText, LLSTRING(cancel), LLSTRING(adjustHeight)] call ace_interaction_fnc_showMouseHint;

private _mouseClickID = [player, "DefaultAction", {GVAR(isPlacing) isEqualTo PLACE_WAITING}, {GVAR(isPlacing) = PLACE_APPROVE}] call ace_common_fnc_addActionEventHandler;

[{
    params ["_args", "_PFHID"];
    _args params ["_flag", "_color", "_mouseClickID"];

    if ((isNull _flag) || {!([player, _flag] call ace_common_fnc_canInteractWith)}) then {
        GVAR(isPlacing) = PLACE_CANCEL;
    };

    if !(GVAR(isPlacing) isEqualTo PLACE_WAITING) exitWith {
        [_PFHID] call CBA_fnc_removePerFrameHandler;
        call ace_interaction_fnc_hideMouseHint;
        [player, "DefaultAction", _mouseClickID] call ace_common_removeActionEventHandler;

        if (GVAR(isPlacing) isEqualTo PLACE_APPROVE) then {
            GVAR(isPlacing) = PLACE_CANCEL;

            //end position of the flag
            player playAction "putdown";

            [{(animationState player select [25, 7]) isEqualTo "putdown"}, {
                params ["_flag", "_color"];

                private _posFlag = getPosWorld _flag;
                private _dirFlag = getDir _flag;
                private _flagTexture = flagTexture _flag;
                deleteVehicle _flag;

                player removeItem format [QGVAR(%1), _color];

                private _globalFlag = "FlagChecked_F" createVehicle [0, 0, 0];
                _globalFlag setFlagTexture _flagTexture;
                _globalFlag setPosWorld _posFlag;
                _globalFlag setDir _dirFlag;

                [_globalFlag] remoteExecCall [QFUNC(pickupFlag), 0, _globalFlag];
            }, [_flag, _color]] call CBA_fnc_waitUntilAndExecute;
        } else {
            //action is canceled
            deleteVehicle _flag;
        };
    };

    //alternativ to "player getRelPos [MAX_DISTANCE, 0]" because flag wasn't in the center of the view
    private _pos = ((eyePos player) vectorAdd ((getCameraViewDirection player) vectorMultiply MAX_DISTANCE));
    //adjust height of flag with the scroll wheel
    _pos set [2, ((getPosWorld player) select 2) + GVAR(objectHeight)];

    _flag setPosWorld _pos;
    _flag setDir (getDir player);
}, 0, [_flag, _color, _mouseClickID]] call CBA_fnc_addPerFrameHandler;
