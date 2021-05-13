#include "script_component.hpp"
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

["Metis", LLSTRING(artillery), {
    params [["_modulePosition", [0,0,0], [[]]]];

    //open UI
    [
        LLSTRING(artillery_pos),
        [
            ["COMBO", LLSTRING(artillery_ammoType), [[0, 1, 2, 3], ["HE (155mm)","HE (82mm)","SMOKE","ILLUM"], 0]],
            ["COMBO", LLSTRING(artillery_centerPositionType), [[0, 1], [LLSTRING(artillery_modulePos), LLSTRING(artillery_customPos)], 0]],
            ["EDIT", LLSTRING(artillery_centerPositionXPos), ["0000"]],
            ["EDIT", LLSTRING(artillery_centerPositionYPos), ["0000"]],
            ["EDIT", LLSTRING(artillery_areaLenght), ["100"]],
            ["EDIT", LLSTRING(artillery_areaWidth), ["100"]],
            ["EDIT", LLSTRING(artillery_areaAngle), ["0000"]],
            ["EDIT", LLSTRING(artillery_timeOnTarget), ["5"]]
        ],
        {
            private "_position";
            params ["_dialogData", "_modulePosition"];
            _dialogData params ["_ammoType", "_positionType", "_positionX", "_positionY", "_areaLenght", "_areaWidth", "_areaAngle", "_timeOnTarget"];

            _areaLenght = (parseNumber _areaLenght) / 2;
            _areaWidth = (parseNumber _areaWidth) / 2;
            _areaAngle = parseNumber _areaAngle;

            _timeOnTarget = parseNumber _timeOnTarget;

            if (_areaAngle < 0 || _areaAngle > 6400) exitWith {
                [LLSTRING(artillery_errorInvalidAngle)] call zen_common_fnc_showMessage;
            };

            //calculate mils in degree
            _areaAngle = _areaAngle * 0.05625;

            if (_positionType isEqualTo 1 && (_positionX isEqualTo "" || _positionY isEqualTo "")) exitWith {
                [LLSTRING(artillery_errorNoPos)] call zen_common_fnc_showMessage;
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
                    [FUNC(artyFireMissionHE), [_position, "Sh_155mm_AMOS", [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget]] call CBA_fnc_execNextFrame;
                };
                if (_ammoType isEqualTo 1) exitWith {
                    [FUNC(artyFireMissionHE), [_position, "Sh_82mm_AMOS", [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget]] call CBA_fnc_execNextFrame;
                };
                if (_ammoType isEqualTo 2) exitWith {
                    [FUNC(artyFireMissionSMOKE), [_position, [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget]] call CBA_fnc_execNextFrame;
                };
                if (_ammoType isEqualTo 3) exitWith {
                    [FUNC(artyFireMissionILLUM), [_position, [_areaLenght, _areaWidth, _areaAngle], _timeOnTarget]] call CBA_fnc_execNextFrame;
                };
            };
        },
        {},
        _modulePosition
    ] call zen_dialog_fnc_create;
}] call zen_custom_modules_fnc_register;
