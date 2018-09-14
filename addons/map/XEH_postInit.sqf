#include "script_component.hpp"

CHECK(!hasinterface);

private _worldMap = format["Land_Map_%1_F", worldName];
if (!isNull (configFile >> "CfgVehicles" >> _worldMap)) then {
    GVAR(itemMapClassname) = _worldMap;
} else {
    GVAR(itemMapClassname) = "Land_Map_Altis_F";
};

["visibleMap", {
    params ["_unit", "_isMapShown"];

    if (player isEqualTo _unit && !_isMapShown && !isNull GVAR(map)) then {
        if (!GVAR(hasMap)) then {
            player unlinkItem "ItemMap";
        };

        GVAR(map) = objNull;
    };
}] call CBA_fnc_addPlayerEventhandler;

call FUNC(addPlaceMapAction);

GVAR(map) = objNull;
[QGVAR(removeMap),{
    params ["_map"];

    if (visibleMap && {_map isEqualTo GVAR(map)}) then {
        openMap false;
    };
}] call CBA_fnc_addEventHandler;
