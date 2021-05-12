#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0: [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 *  Example:
 *      [[arguments]] call [function name]
 *
 */

 private _action = [
    "MeasureDistance",
    "Measure Distance",
    "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa",
    {
        params ["_position"];

        [_position, {}, "", "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa", [1, 0, 0, 1], 45, {
            params ["_startPosAGL", "_mousePos", "_text", "_icon", "_color", "_angle", "_is3d"];

            private _distance = _startPosAGL vectorDistance _mousePos;
            private _azimuth = _startPosAGL getDir _mousePos;

            private _newText = format ["%1 m - %2°", round _distance, round _azimuth];

            [[_mousePos, _newText, _icon, _color, _angle], [_startPosAGL, _mousePos, _color]]
        }] call mts_zeus_fnc_getModuleDestination;
    }
] call zen_context_menu_fnc_createAction;
[_action, [], 0] call zen_context_menu_fnc_addAction;
