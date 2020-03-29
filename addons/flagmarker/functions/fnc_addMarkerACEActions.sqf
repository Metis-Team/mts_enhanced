/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds ACE interactions for marker actions to the player.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_flagmarker_fnc_addMarkerACEActions
 *
 */
#include "script_component.hpp"

CHECK(!hasInterface);

private _markerAction = [
    QGVAR(markerAction),
    LLSTRING(marker),
    QPATHTOF(data\ui\mts_flag_white_icon.paa),
    {},
    {
        params ["", "_player"];

        private _items = [_player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems;

        [_player, objNull] call ace_common_fnc_canInteractWith &&
        (
            (QGVAR(marker_yellow) in _items) ||
            (QGVAR(marker_mines) in _items)
        )
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _markerAction] call ace_interact_menu_fnc_addActionToClass;

private _placeMarkerYellowAction = [
    QGVAR(placeMarkerYellowAction),
    format [LLSTRING(placeItem), LLSTRING(markerYellowDisplayName)],
    QPATHTOF(data\ui\mts_flag_yellow_place_icon.paa),
    {
        [
            "FlagSmall_F",
            LLSTRING(markerYellowDisplayName),
            nil,
            {
                params ["", "_player"];
                _player removeItem QGVAR(marker_yellow);
            },
            {
                params ["", "_player"];
                _player addItem QGVAR(marker_yellow);
            },
            nil,
            0,
            QPATHTOF(data\ui\mts_flag_pickup_icon.paa),
            [0, 0, 0.6],
            2
        ] call FUNC(placeItem);
    },
    {
        params ["", "_player"];

        QGVAR(marker_yellow) in ([_player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems)
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(markerAction)], _placeMarkerYellowAction] call ace_interact_menu_fnc_addActionToClass;

private _placeMarkerMinesAction = [
    QGVAR(placeMarkerMinesAction),
    format [LLSTRING(placeItem), LLSTRING(markerMinesDisplayName)],
    QPATHTOF(data\ui\mts_flag_yellow_place_icon.paa),
    {
        [
            "Land_Sign_MinesTall_English_F",
            LLSTRING(markerMinesDisplayName),
            nil,
            {
                params ["", "_player"];
                _player removeItem QGVAR(marker_mines);
            },
            {
                params ["", "_player"];
                _player addItem QGVAR(marker_mines);
            },
            nil,
            0,
            nil,
            [0, 0, 0.55],
            2
        ] call FUNC(placeItem);
    },
    {
        params ["", "_player"];

        QGVAR(marker_mines) in ([_player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems)
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(markerAction)], _placeMarkerMinesAction] call ace_interact_menu_fnc_addActionToClass;
