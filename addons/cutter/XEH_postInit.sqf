#include "script_component.hpp"

CHECK(!hasinterface);

private _cfgWeapons = configFile >> "CfgWeapons";
private _itemsAbleToCutBushes = (call (uiNamespace getVariable [QGVAR(itemsAbleToCutBushes), {[]}])) apply {_cfgWeapons >> _x};
{
    private _name = configName _x;

    GVAR(bushCutterCache) set [_name, 1];
} forEach _itemsAbleToCutBushes;

// Support for other tools able to cut bushes without mod dependency
GVAR(bushCutterCache) set ["ACE_EntrenchingTool", 1];


call FUNC(addBushCutter);
call FUNC(addGrassCutter);
