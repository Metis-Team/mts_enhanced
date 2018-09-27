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
 *      call mts_flagmarker_fnc_addACEActions
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
        [player, objNull] call ace_common_fnc_canInteractWith &&
        (
            (QGVAR(red) in (items player)) ||
            (QGVAR(blue) in (items player)) ||
            (QGVAR(green) in (items player)) ||
            (QGVAR(yellow) in (items player)) ||
            !((getForcedFlagTexture player) isEqualTo "")
        )
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment"], _flagAction] call ace_interact_menu_fnc_addActionToClass;

//Attach flag to player actions
private _carryRedFlagAction = [
    QGVAR(carryRedFlagAction),
    format [LLSTRING(carryFlag), LLSTRING(red)],
    QPATHTOF(data\ui\mts_flag_red_carry_icon.paa),
    {
        ["red"] call FUNC(carryFlag);
    },
    {
        (QGVAR(red) in (items player)) &&
        ((getForcedFlagTexture player) isEqualTo "")
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _carryRedFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _carryBlueFlagAction = [
    QGVAR(carryBlueFlagAction),
    format [LLSTRING(carryFlag), LLSTRING(blue)],
    QPATHTOF(data\ui\mts_flag_blue_carry_icon.paa),
    {
        ["blue"] call FUNC(carryFlag);
    },
    {
        (QGVAR(blue) in (items player)) &&
        ((getForcedFlagTexture player) isEqualTo "")
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _carryBlueFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _carryGreenFlagAction = [
    QGVAR(carryGreenFlagAction),
    format [LLSTRING(carryFlag), LLSTRING(green)],
    QPATHTOF(data\ui\mts_flag_green_carry_icon.paa),
    {
        ["green"] call FUNC(carryFlag);
    },
    {
        (QGVAR(green) in (items player)) &&
        ((getForcedFlagTexture player) isEqualTo "")
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _carryGreenFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _carryYellowFlagAction = [
    QGVAR(carryYellowFlagAction),
    format [LLSTRING(carryFlag), LLSTRING(yellow)],
    QPATHTOF(data\ui\mts_flag_yellow_carry_icon.paa),
    {
        ["yellow"] call FUNC(carryFlag);
    },
    {
        (QGVAR(yellow) in (items player)) &&
        ((getForcedFlagTexture player) isEqualTo "")
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _carryYellowFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _furlFlagAction = [
    QGVAR(furlFlagAction),
    LLSTRING(furlFlag),
    QPATHTOF(data\ui\mts_flag_furl_icon.paa),
    {
        [""] call FUNC(carryFlag);
    },
    {
        !((getForcedFlagTexture player) isEqualTo "")
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _furlFlagAction] call ace_interact_menu_fnc_addActionToClass;

//Place
private _placeRedFlagAction = [
    QGVAR(placeRedFlagAction),
    format [LLSTRING(placeFlag), LLSTRING(red)],
    QPATHTOF(data\ui\mts_flag_red_place_icon.paa),
    {
        ["red"] call FUNC(placeFlag);
    },
    {
        (QGVAR(red) in (items player))
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _placeRedFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _placeBlueFlagAction = [
    QGVAR(placeBlueFlagAction),
    format [LLSTRING(placeFlag), LLSTRING(blue)],
    QPATHTOF(data\ui\mts_flag_blue_place_icon.paa),
    {
        ["blue"] call FUNC(placeFlag);
    },
    {
        (QGVAR(blue) in (items player))
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _placeBlueFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _placeGreenFlagAction = [
    QGVAR(placeGreenFlagAction),
    format [LLSTRING(placeFlag), LLSTRING(green)],
    QPATHTOF(data\ui\mts_flag_green_place_icon.paa),
    {
        ["green"] call FUNC(placeFlag);
    },
    {
        (QGVAR(green) in (items player))
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _placeGreenFlagAction] call ace_interact_menu_fnc_addActionToClass;

private _placeYellowFlagAction = [
    QGVAR(placeYellowFlagAction),
    format [LLSTRING(placeFlag), LLSTRING(yellow)],
    QPATHTOF(data\ui\mts_flag_yellow_place_icon.paa),
    {
        ["yellow"] call FUNC(placeFlag);
    },
    {
        (QGVAR(yellow) in (items player))
    }
] call ace_interact_menu_fnc_createAction;
[(typeOf player), 1, ["ACE_SelfActions", "ACE_Equipment", QGVAR(flagAction)], _placeYellowFlagAction] call ace_interact_menu_fnc_addActionToClass;
