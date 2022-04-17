#include "script_component.hpp"

CHECK(!hasinterface);

private _worldMap = format ["Land_Map_%1_F", worldName];
if (!isNull (configFile >> "CfgVehicles" >> _worldMap)) then {
    GVAR(itemMapClassname) = _worldMap;
} else {
    GVAR(itemMapClassname) = "Land_Map_Altis_F";
};

["visibleMap", {
    params ["_unit", "_isMapShown"];

    if (ACE_player isEqualTo _unit && !_isMapShown && !isNull GVAR(map)) then {
        if (!GVAR(hasMap)) then {
            [_unit] call FUNC(removeMap);
        };

        GVAR(map) = objNull;
    };
}] call CBA_fnc_addPlayerEventhandler;

GVAR(map) = objNull;
[QGVAR(removeMap), {
    params ["_map"];

    if (visibleMap && {_map isEqualTo GVAR(map)}) then {
        openMap false;
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(addMapActions), {
    _this call FUNC(addOpenMapAction);
    _this call FUNC(addPickupMapAction);
}] call CBA_fnc_addEventHandler;

call FUNC(addPlaceMapAction);
