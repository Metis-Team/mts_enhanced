/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds zeus module for a custom artillery script.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_zeus_fnc_moduleArtillery
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

["vLehrBrig16", LLSTRING(artillery), {
    params [["_modulePosition", [0,0,0], [[]]]];
    private ["_position"];

    //open UI
    private _dialog_ammoType = [
        LLSTRING(artillery_pos),
        [
            [LLSTRING(artillery_ammoType), ["HE (155mm)","HE (82mm)","SMOKE","ILLUM"], 0],
            [LLSTRING(artillery_centerPositionType), [LLSTRING(artillery_modulePos), LLSTRING(artillery_customPos)], 0],
            [LLSTRING(artillery_centerPositionXPos), "", "0000"],
            [LLSTRING(artillery_centerPositionYPos), "", "0000"],
            [LLSTRING(artillery_areaLenght), "", "100"],
            [LLSTRING(artillery_areaWidth), "", "100"],
            [LLSTRING(artillery_areaAngle), "", "0000"],
            [LLSTRING(artillery_timeOnTarget), "", "5"]
        ]
    ] call Ares_fnc_showChooseDialog;

    CHECK(_dialog_ammoType isEqualTo []);
    _dialog_ammoType params ["_ammoType", "_positionType", "_positionX", "_positionY", "_areaLenght", "_areaWidth", "_areaAngle", "_timeOnTarget"];

    _areaLenght = (parseNumber _areaLenght) / 2;
    _areaWidth = (parseNumber _areaWidth) / 2;
    _areaAngle = parseNumber _areaAngle;

    _timeOnTarget = parseNumber _timeOnTarget;

    if (_areaAngle < 0 || _areaAngle > 6400) exitWith {
        [LLSTRING(artillery_errorInvalidAngle)] call Ares_fnc_ShowZeusMessage;
    };

    //calculate mils in degree
    _areaAngle = _areaAngle * 0.05625;

    if (_positionType isEqualTo 1 && (_positionX isEqualTo "" || _positionY isEqualTo "")) exitWith {
        [LLSTRING(artillery_errorNoPos)] call Ares_fnc_ShowZeusMessage;
    };

    if (_positionType isEqualTo 0) then {
        //use module position
        _position = _modulePosition;
    } else {
        //use custom position
        _positionX = parseNumber _positionX;
        _positionY = parseNumber _positionY;
        _position = [_positionX, _positionY] call CBA_fnc_mapGridToPos;
        _position set [2, 0];
    };

    call {
        if (_ammoType isEqualTo 0) exitWith {
            [_position, "Sh_155mm_AMOS", [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget] call FUNC(artyFireMissionHE);
        };
        if (_ammoType isEqualTo 1) exitWith {
            [_position, "Sh_82mm_AMOS", [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget] call FUNC(artyFireMissionHE);
        };
        if (_ammoType isEqualTo 2) exitWith {
            [_position, [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget] call FUNC(artyFireMissionSMOKE);
        };
        if (_ammoType isEqualTo 3) exitWith {
            [_position, [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget] call FUNC(artyFireMissionILLUM);
        };
    };
}] call Ares_fnc_RegisterCustomModule;
