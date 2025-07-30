#include "script_component.hpp"
/*
 * Authors: Timi007
 * Handles the mouse button event when user wants to add a plot in 3D or on the map.
 *
 * Arguments:
 * 0: Zeus display <DISPLAY>
 * 1: Mouse button pressed <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display, 1] call mts_zeus_plotting_fnc_onMouseButtonDown
 *
 * Public: No
 */

params ["_display", "_button"];

if (_button != 0 || {GVAR(activePlot) isEqualTo []}) exitWith {};
TRACE_1("onMouseButtonDown",_this);

if (call zen_common_fnc_isCursorOnMouseArea) then {
    curatorMouseOver params ["_mouseOverType", "_object"];

    private _endPosOrObj = switch (true) do {
        case (_mouseOverType isEqualTo "OBJECT"): {_object};
        case (visibleMap): {
            private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

            private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
            _pos2D set [2, getTerrainHeightASL _pos2D];
            _pos2D
        };
        default {[zen_common_mousePos, 2] call zen_common_fnc_getPosFromScreen};
    };

    // Check if end point already has a valid plot attached to it
    private _attachedPlot = -1;
    if (_endPosOrObj isEqualType objNull) then {
        _attachedPlot = _endPosOrObj getVariable [QGVAR(attachedPlot), -1];
    };

    if (_attachedPlot isNotEqualTo -1 && {[_attachedPlot] call FUNC(isValidPlot)}) then {
        [LSTRING(ErrorCannotAttachPlot)] call zen_common_fnc_showMessage;
    } else {
        // Add current active plot to permanent ones
        GVAR(activePlot) params ["_type", "_startPosOrObj"];

        TRACE_4("Add plot",_type,_startPosOrObj,_endPosOrObj,_this);
        [QGVAR(plotAdded), [_type, _startPosOrObj, _endPosOrObj]] call CBA_fnc_localEvent;
    };
};

GVAR(activePlot) = [];
