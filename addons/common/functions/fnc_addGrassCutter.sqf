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
#include "script_component.hpp"

CHECK(!GVAR(grasscutter_enabled) || !hasinterface);

private _action = [
    QGVAR(grasscutterAction),
    LLSTRING(grasscutter_removeGrass),
    QPATHTOF(ui\mts_grasscutter.paa),
    {
        if ((stance player) isEqualTo "PRONE") then {
            player playMove "AinvPpneMstpSnonWnonDnon_Putdown_AmovPpneMstpSnonWnonDnon";
        } else {
            player playMove "AinvPknlMstpSnonWnonDnon_medic0";
        };

        [5, [], {
            private _cutter = GVAR(grasscutter_size) createVehicle [0,0,0];
            _cutter setPos (getpos player);
        }, {}, LLSTRING(grasscutter_removeGrass)
        ] call ace_common_fnc_progressBar;
    },
    {
        [player, objNull] call ace_common_fnc_canInteractWith;
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _action] call ace_interact_menu_fnc_addActionToClass;
