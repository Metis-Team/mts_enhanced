#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007
 *
 *  Description:
 *      Adds grasscutter interaction to player.
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_common_fnc_addGrassCutter
 *
 */

CHECK(!GVAR(grasscutter_enabled) || !hasinterface);

private _action = [
    QGVAR(grasscutter),
    LLSTRING(grasscutter_removeGrass),
    QPATHTOF(ui\mts_grasscutter.paa),
    {
        params ["", "_player"];

        if ((stance _player) isEqualTo "PRONE") then {
            _player playMove "AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon";
        } else {
            _player playMove "AinvPknlMstpSnonWnonDnon_medic0";
        };

        [GVAR(grasscutter_duration), [_player], {
            (_this select 0) params ["_player"];

            private _cutterType = ["Land_ClutterCutter_Large_F", "Land_ClutterCutter_Medium_F"] select GVAR(grasscutter_size);

            private _cutter = _cutterType createVehicle [0, 0, 0];
            _cutter setPosATL (getPosATL _player);
        }, {}, LLSTRING(grasscutter_removeGrass)
        ] call ace_common_fnc_progressBar;
    },
    {
        params ["", "_player"];
        [_player, objNull] call ace_common_fnc_canInteractWith
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf ACE_player), 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
