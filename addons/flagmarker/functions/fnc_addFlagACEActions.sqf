/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds ACE interactions for flag actions to the player.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_flagmarker_fnc_addFlagACEActions
 *
 */
#include "script_component.hpp"

CHECK(!hasInterface);

private _flagAction = [
    QGVAR(flagAction),
    LLSTRING(flags),
    QPATHTOF(data\ui\mts_flag_white_icon.paa),
    {},
    {
        params ["", "_player"];

        private _items = [_player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems;

        [_player, objNull] call ace_common_fnc_canInteractWith &&
        (

            (QGVAR(flag_red) in _items) ||
            (QGVAR(flag_blue) in _items) ||
            (QGVAR(flag_green) in _items) ||
            (QGVAR(flag_yellow) in _items) ||
            !((getForcedFlagTexture _player) isEqualTo "")
        )
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _flagAction] call ace_interact_menu_fnc_addActionToClass;

private _furlFlagAction = [
    QGVAR(furlFlagAction),
    LLSTRING(furlFlag),
    QPATHTOF(data\ui\mts_flag_furl_icon.paa),
    {
        [""] call FUNC(carryFlag);
    },
    {
        params ["", "_player"];

        !((getForcedFlagTexture _player) isEqualTo "")
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _furlFlagAction] call ace_interact_menu_fnc_addActionToClass;

{
    private _color = toLower _x;
    private _displayName = localize format [LSTRING(flag%1DisplayName), _x];

    private _carryFlagAction = [
        format [QGVAR(carry%1FlagAction), _x],
        format [LLSTRING(carryItem), _displayName],
        format [QPATHTOF(data\ui\mts_flag_%1_carry_icon.paa), _color],
        {
            params ["", "", "_color"];

            [_color] call FUNC(carryFlag);
        },
        {
            params ["", "_player", "_color"];

            (format [QGVAR(flag_%1), _color] in ([_player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems)) &&
            ((getForcedFlagTexture _player) isEqualTo "")
        },
        {},
        _color
    ] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _carryFlagAction] call ace_interact_menu_fnc_addActionToClass;
} forEach ["Red", "Blue", "Green", "Yellow"];

{
    private _color = toLower _x;
    private _displayName = localize format [LSTRING(flag%1DisplayName), _x];

    private _placeFlagAction = [
        format [QGVAR(place%1FlagAction), _x],
        format [LLSTRING(placeItem), _displayName],
        format [QPATHTOF(data\ui\mts_flag_%1_place_icon.paa), _color],
        {
            params ["", "", "_args"];
            _args params ["_color", "_displayName"];

            [
                "FlagChecked_F",
                _displayName,
                {
                    params ["_flag", "", "_color"];

                    if (_color isEqualTo "yellow") then {
                        _flag setFlagTexture QPATHTOF(data\Flag_yellow_co.paa);
                    } else {
                        _flag setFlagTexture format ["\A3\Data_F\Flags\Flag_%1_co.paa", _color];
                    };
                },
                {
                    params ["_flag", "_player", "_color"];

                    if (_color isEqualTo "yellow") then {
                        _flag setFlagTexture QPATHTOF(data\Flag_yellow_co.paa);
                    } else {
                        _flag setFlagTexture format ["\A3\Data_F\Flags\Flag_%1_co.paa", _color];
                    };

                    _player removeItem format [QGVAR(flag_%1), _color];
                },
                {
                    params ["", "_player", "_color"];

                    _player addItem format [QGVAR(flag_%1), _color];
                },
                _color,
                nil,
                QPATHTOF(data\ui\mts_flag_pickup_icon.paa),
                [0, -0.45, 1.25],
                2
            ] call FUNC(placeItem);
        },
        {
            params ["", "_player", "_args"];
            _args params ["_color"];

            format [QGVAR(flag_%1), _color] in ([_player, false, true, true, true, false] call CBA_fnc_uniqueUnitItems)
        },
        {},
        [_color, _displayName]
    ] call ace_interact_menu_fnc_createAction;
    [(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _placeFlagAction] call ace_interact_menu_fnc_addActionToClass;
} forEach ["Red", "Blue", "Green", "Yellow"];
