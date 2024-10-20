#include "script_component.hpp"

#include "XEH_PREP.hpp"

private _itemsAbleToCutBushes = (configProperties [configFile >> "CfgWeapons", QUOTE(isClass _x && {(getNumber (_x >> QQGVAR(canCutBushes))) isEqualTo 1}), true]) apply {configName _x};
uiNamespace setVariable [QGVAR(itemsAbleToCutBushes), compileFinal str _itemsAbleToCutBushes];
