/**
 *  Author: Timi007
 *
 *  Description:
 *      Shows an icon for unconscious players in the zeus interface.
 *
 *  Parameter(s):
 *      0: OBJECT - Unit.
 *      1: BOOLEAN - Is the unit unconscious?
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [_unit, true] call mts_zeus_fnc_drawACEUnconsciousIcon
 *
 */
#include "script_component.hpp"
params[["_unit", objnull, [objnull]], ["_isUnconscious", false, [false]]];
private["_iconID"];

private _curatorModule = getAssignedCuratorLogic player;
private _iconIDArray = _curatorModule getVariable [QGVAR(iconIDArray), []];

if (_isUnconscious) then {
    _iconID = [_curatorModule, [
        "z\ace\addons\zeus\ui\Icon_Module_Zeus_Unconscious_ca.paa", /*"kia" call BIS_fnc_textureMarker,*/
        [1,0,0,1], //color
        [(getPos _unit) select 0, (getPos _unit) select 1, 2],
        1.5,
        1.5,
        0,
        "",
        1
    ]] call BIS_fnc_addCuratorIcon;
    _iconIDArray pushbackUnique [_unit, _iconID];
    _curatorModule setVariable [QGVAR(iconIDArray), _iconIDArray];
} else {
    private _iconIndex = _iconIDArray findIf {(_x select 0) isEqualTo _unit};
    private _iconID = (_iconIDArray select _iconIndex) select 1;
    [_curatorModule, _iconID] call BIS_fnc_removeCuratorIcon;
    _iconIDArray deleteAt _iconIndex;
};
