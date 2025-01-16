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
                ["COMBO", LLSTRING(artillery_ammoType), [[0, 1, 2, 3], ["HE (155mm)","HE (82mm)","SMOKE","ILLUM"], 0]],
                ["COMBO", LLSTRING(artillery_centerPositionType), [[0, 1], [LLSTRING(artillery_modulePos), LLSTRING(artillery_customPos)], 0]],
                ["VECTOR", LLSTRING(artillery_centerPositionPos), [0, 0]],
                ["VECTOR", LLSTRING(artillery_area), [100, 100]],
                ["SLIDER", LLSTRING(artillery_areaAngle), [0, 6399, 0, 0]]
            ],
            {
                private "_position";
                params ["_dialogData", "_modulePosition"];
                _dialogData params ["_ammoType", "_positionType", "_positionXY", "_area", "_areaAngle"];

                // Convert mils to degree
                _areaAngle = _areaAngle * 0.05625;

                private _position = if (_positionType isEqualTo 0) then {
                    //use module position
                    _modulePosition
                } else {
                    //use custom position
                    _positionXY call CBA_fnc_mapGridToPos
                };

                private _group = createGroup [sideLogic, true];
                private _targetLogic = _group createUnit [QGVAR(moduleArtyTarget), [0, 0, 0], [], 0, "CAN_COLLIDE"];
                _targetLogic setPosATL [_position select 0, _position select 1, 0];
                _targetLogic setDir _areaAngle;
                [zen_position_logics_fnc_add, [_targetLogic, LLSTRING(artillery_fireMission)]] call CBA_fnc_execNextFrame;

                private _targetArea = [_targetLogic, _area select 0, _area select 1];
                private _jipID = [QGVAR(visualizeArtyTargetArea), _targetArea] call CBA_fnc_globalEventJIP;
                [_jipID, _targetLogic] call CBA_fnc_removeGlobalEventJIP;

                switch (_ammoType) do {
                    case 0: {
                        [FUNC(artyFireMissionHE), [_targetArea, "Sh_155mm_AMOS"]] call CBA_fnc_execNextFrame;
                    };
                    case 1: {
                        [FUNC(artyFireMissionHE), [_targetArea, "Sh_82mm_AMOS"]] call CBA_fnc_execNextFrame;
                    };
                    case 2: {
                        [FUNC(artyFireMissionSMOKE), [_targetArea]] call CBA_fnc_execNextFrame;
                    };
                    case 3: {
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
