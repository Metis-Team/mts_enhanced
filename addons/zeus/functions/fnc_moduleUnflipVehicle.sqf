/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds zeus module for unflipping vehicles.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_moduleUnflipVehicle
 *
 */
#include "script_component.hpp"

CHECK(!hasinterface);

["vLehrBrig16", LLSTRING(unflipVehicle),
    {
        params["", ["_vehicle", objNull, [objNull]]];

        if (!(_vehicle isKindOf "LandVehicle") || {isnull _vehicle}) exitWith {
            [LLSTRING(unflipVehicle_noVeh)] call Ares_fnc_ShowZeusMessage;
        };

        _vehicle setVectorUp (surfaceNormal (getPos _vehicle));
        _vehicle setPosATL [((getPos _vehicle) select 0), ((getPos _vehicle) select 1), 0.5];
    }
] call Ares_fnc_RegisterCustomModule;
