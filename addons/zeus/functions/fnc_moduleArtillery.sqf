#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds Zeus module for a custom artillery script.
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

[LELSTRING(main,category), LLSTRING(artillery),
    {
        params [["_modulePosition", [0,0,0], [[]]]];

        //open UI
        [
            LLSTRING(artillery_pos),
            [
                [
                    "COMBO",
                    LLSTRING(artillery_ammoType),
                    [
                        [0, 1, 2],
                        [LLSTRING(artillery_ammoType_he), LLSTRING(artillery_ammoType_smoke), LLSTRING(artillery_ammoType_illum)],
                        0
                    ]
                ],
                ["COMBO", LLSTRING(artillery_centerPositionType), [[0, 1], [LLSTRING(artillery_modulePos), LLSTRING(artillery_customPos)], 0]],
                ["EDIT", [LLSTRING(artillery_centerPositionPosX), LLSTRING(artillery_centerPositionPos_tooltip)], ["", FUNC(positiveNumber)]],
                ["EDIT", [LLSTRING(artillery_centerPositionPosY), LLSTRING(artillery_centerPositionPos_tooltip)], ["", FUNC(positiveNumber)]],
                ["VECTOR", LLSTRING(artillery_area), [100, 100]],
                ["SLIDER", LLSTRING(artillery_areaAngle), [0, 6399, 0, 0]]
            ],
            {
                private "_position";
                params ["_dialogData", "_modulePosition"];
                _dialogData params ["_ammoType", "_positionType", "_mapPositionX", "_mapPositionY", "_area", "_areaAngle"];


                // Convert mils to degree
                _areaAngle = _areaAngle * 0.05625;

                private _position = if (_positionType isEqualTo 0) then {
                    //use module position
                    _modulePosition
                } else {
                    //use custom position
                    [_mapPositionX, _mapPositionY] call CBA_fnc_mapGridToPos
                };

                private _group = createGroup [sideLogic, true];
                private _targetLogic = _group createUnit [QGVAR(moduleArtyTarget), [0, 0, 0], [], 0, "CAN_COLLIDE"];
                _targetLogic setPosATL [_position select 0, _position select 1, 0];
                _targetLogic setDir _areaAngle;

                private _targetArea = [_targetLogic, _area select 0, _area select 1];
                switch (_ammoType) do {
                    case 0: {
                        [FUNC(artyFireMissionHE), [_targetArea]] call CBA_fnc_execNextFrame;
                    };
                    case 1: {
                        [FUNC(artyFireMissionSMOKE), [_targetArea]] call CBA_fnc_execNextFrame;
                    };
                    case 2: {
                        [FUNC(artyFireMissionILLUM), [_targetArea]] call CBA_fnc_execNextFrame;
                    };
                };
            },
            {},
            _modulePosition
        ] call zen_dialog_fnc_create;
    },
    "\a3\ui_f\data\gui\cfg\communicationmenu\artillery_ca.paa"
] call zen_custom_modules_fnc_register;
