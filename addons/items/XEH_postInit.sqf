#include "script_component.hpp"

CHECK(!hasinterface);

GVAR(isPlacing) = PLACE_CANCEL;
["ace_interactMenuOpened", {GVAR(isPlacing) = PLACE_CANCEL;}] call CBA_fnc_addEventHandler;

private _cfgWeapons = configFile >> "CfgWeapons";
private _weapons = (call (uiNamespace getVariable [QGVAR(markerItems), {[]}])) apply {_cfgWeapons >> _x};

{
    private _name = configName _x;
    private _vehicleClass = getText (_x >> QGVAR(vehicle));
    private _displayName = getText (_x >> "displayName");
    private _icon = getText (_x >> QGVAR(icon));
    GVAR(markerCache) set [_name, [_vehicleClass, _displayName, _icon]];

    private _action = [
        QGVAR(pickup),
        LLSTRING(pickupMarker),
        QPATHTOF(data\ui\icons\mts_marker_pickup_icon.paa),
        {call FUNC(pickupMarker)},
        {[_player, _target, []] call ace_common_fnc_canInteractWith},
        {},
        [_name],
        [0, 0.072, 0.2],
        2
    ] call ace_interact_menu_fnc_createAction;
    [_vehicleClass, 0, [], _action] call ace_interact_menu_fnc_addActionToClass;
} forEach _weapons;
