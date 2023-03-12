#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Gets the child actions for placing and carring flags.
 *
 *  Parameter(s):
 *      0: OBJECT - Player.
 *
 *  Returns:
 *       ARRAY - Actions.
 *
 *  Example:
 *      [player] call mts_flags_fnc_getActions
 *
 */

params ["_player"];

private _actions = [];

{
    (GVAR(flagItemCache) get _x) params ["_flagName", "_texture", "_actionIconPlace", "_actionIconCarry"];

    // Place flag
    _actions pushBack [
        [
            "place_" + _x,
            format [LLSTRING(Place), _flagName],
            _actionIconPlace,
            {
                params ["_player", "", "_item"];
                [_player, _item] call FUNC(placeFlag);
            },
            {GVAR(enablePlacing)},
            {},
            _x
        ] call ace_interact_menu_fnc_createAction,
        [],
        _player
    ];

    // Carry flag
    _actions pushBack [
        [
            "carry_" + _x,
            format [LLSTRING(Carry), _flagName],
            _actionIconCarry,
            {
                params ["_player", "", "_item"];
                [_player, _item] call FUNC(carryFlag);
            },
            {GVAR(enableCarrying) && {!([_this select 0] call FUNC(carriesFlag))}}, // Should not carry flag already
            {},
            _x
        ] call ace_interact_menu_fnc_createAction,
        [],
        _player
    ];
} forEach ([_player] call FUNC(getFlags));

_actions
