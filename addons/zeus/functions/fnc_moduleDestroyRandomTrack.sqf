#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds Zeus module for destroying a random track of a tracked vehicle.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_zeus_fnc_moduleDestroyRandomTrack
 *
 */

[LELSTRING(main,category), LLSTRING(destroyRandomTrack),
    {
        params["", ["_vehicle", objNull, [objNull]]];

        if (!(_vehicle isKindOf "LandVehicle") || {isNull _vehicle}) exitWith {
            [LLSTRING(noVehicle)] call zen_common_fnc_showMessage;
        };

        private _track = selectRandom ["hitltrack", "hitrtrack"];
        [QGVAR(setHitPointDamage), [_vehicle, [_track, 1, true, player, player]], _vehicle] call CBA_fnc_targetEvent;
    },
    "\a3\data_f_tank\logos\arma3_tank_icon_ca.paa"
] call zen_custom_modules_fnc_register;
