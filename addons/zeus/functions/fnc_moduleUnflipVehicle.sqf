#include "script_component.hpp"
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

[LELSTRING(main,category), LLSTRING(unflipVehicle),
    {
        params["", ["_vehicle", objNull, [objNull]]];

        if (!(_vehicle isKindOf "LandVehicle") || {isNull _vehicle}) exitWith {
            [LLSTRING(unflipVehicle_noVeh)] call zen_common_fnc_showMessage;
        };

        _vehicle setVectorUp (surfaceNormal (getPos _vehicle));
        _vehicle setPosATL [((getPos _vehicle) select 0), ((getPos _vehicle) select 1), 0.5];
    },
    "\a3\ui_f\data\gui\cfg\cursors\rotate3d_gs.paa"
] call zen_custom_modules_fnc_register;
