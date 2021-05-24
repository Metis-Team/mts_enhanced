#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds the measure distance action to the zeus context menu.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_contextMeasureDistance
 *
 */

 private _action = [
    QGVAR(measureDistance),
    LLSTRING(measureDistance),
    "\a3\ui_f\data\IGUI\Cfg\Actions\autohover_ca.paa",
    {
        params ["_position"];

        [_position, {}, [], "", "\a3\ui_f\data\map\markerbrushes\cross_ca.paa", [0.1, 0.2, 1, 1], 0, true, true, {
            params ["_startPosAGL", "_mousePosAGL", "_text", "_icon", "_color", "_angle", "_is3d"];

            private _distance = _startPosAGL vectorDistance _mousePosAGL;
            private _azimuth = _startPosAGL getDir _mousePosAGL;

            private _newText = format ["%1 m - %2°", _distance toFixed 1, floor _azimuth];

            [[_mousePosAGL, _newText, _icon, _color, _angle], [_startPosAGL, _mousePosAGL, _color]]
        }] call FUNC(getModuleDestination);
    },
    {
        !GVAR(moduleDestination_running)
    }
] call zen_context_menu_fnc_createAction;
[_action, [], 0] call zen_context_menu_fnc_addAction;
