#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      adds multiple useful chat commands
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      call mts_common_fnc_addChatCommands
 *
 */

if (isServer) then {
    [QGVAR(createZeus), {
        params [["_unit", objNull, [objNull]]];
        if (isNull _unit || {!isNull getAssignedCuratorLogic _unit}) exitWith {};

        // Cleanup on disconnect
        if (isNil QGVAR(createZeusDC)) then {
            GVAR(createZeusDC) = addMissionEventHandler ["HandleDisconnect", {
                params ["", "", "_owner"];

                private _curatorVar = format [QGVAR(zeus_%1), _owner];
                private _curator = missionNamespace getVariable _curatorVar;

                if (!isNil "_curator") then {
                    if (!isNull _curator) then {deleteVehicle _curator};
                    missionNamespace setVariable [_curatorVar, nil];
                };
            }];
        };

        private _owner = ["#adminLogged", getPlayerUID _player] select isMultiplayer;
        private _group = createGroup [sideLogic, true];
        private _curator = _group createUnit ["ModuleCurator_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        missionNamespace setVariable [format [QGVAR(zeus_%1), _owner], _curator];

        _curator setVariable ["Addons", 3, true];
        _curator setVariable ["BIS_fnc_initModules_disableAutoActivation", false];

        _curator addCuratorEditableObjects [(allMissionObjects "" - entities [["Logic"], []]), true];
        _unit assignCurator _curator;

        [LLSTRING(chatCommands_zeusCreated)] remoteExecCall ["hint", _unit];
    }] call CBA_fnc_addEventHandler;
};

CHECK(!hasInterface);

["zeus", {
    params ["_name"];
    private _unit = objNull;

    switch (toLower _name) do {
        case (""): {
            _unit = player;
        };
        case ("getname"): {
            private _cursorObject = cursorObject;
            if (_cursorObject isKindOf "CAManBase" && {isPlayer _cursorObject}) then {
                _unit = _cursorObject;
            };
        };
        default {
            _unit = _name call FUNC(parseNameToPlayer);
        };
    };
    if (isNull _unit) exitWith {};

    [QGVAR(createZeus), [_unit]] call CBA_fnc_serverEvent;
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["medic", {
    params ["_name"];
    private _unit = objNull;

    switch (toLower _name) do {
        case (""): {
            _unit = player;
        };
        case ("getname"): {
            private _cursorObject = cursorObject;
            if (_cursorObject isKindOf "Man") then {
                _unit = _cursorObject;
            };
        };
        default {
            _unit = _name call FUNC(parseNameToPlayer);
        };
    };
    CHECK(isNull _unit);

    _unit setVariable ["ACE_medical_medicClass", 1, true];
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["doctor", {
    params ["_name"];
    private _unit = objNull;

    switch (toLower _name) do {
        case (""): {
            _unit = player;
        };
        case ("getname"): {
            private _cursorObject = cursorObject;
            if (_cursorObject isKindOf "Man") then {
                _unit = _cursorObject;
            };
        };
        default {
            _unit = _name call FUNC(parseNameToPlayer);
        };
    };
    CHECK(isNull _unit);

    _unit setVariable ["ACE_medical_medicClass", 2, true];
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["eng", {
    params ["_name"];
    private _unit = objNull;

    switch (toLower _name) do {
        case (""): {
            _unit = player;
        };
        case ("getname"): {
            private _cursorObject = cursorObject;
            if (_cursorObject isKindOf "Man") then {
                _unit = _cursorObject;
            };
        };
        default {
            _unit = _name call FUNC(parseNameToPlayer);
        };
    };
    CHECK(isNull _unit);

    _unit setVariable ["ACE_isEngineer", 1, true];
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["adveng", {
    params ["_name"];
    private _unit = objNull;

    switch (toLower _name) do {
        case (""): {
            _unit = player;
        };
        case ("getname"): {
            private _cursorObject = cursorObject;
            if (_cursorObject isKindOf "Man") then {
                _unit = _cursorObject;
            };
        };
        default {
            _unit = _name call FUNC(parseNameToPlayer);
        };
    };
    CHECK(isNull _unit);

    _unit setVariable ["ACE_isEngineer", 2, true];
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["healall", {
    {
        ["ace_medical_treatment_fullHealLocal", _x, _x] call CBA_fnc_targetEvent;
    } forEach (call CBA_fnc_players);
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["heal", {
    params ["_name"];
    private _unit = objNull;

    switch (toLower _name) do {
        case (""): {
            _unit = player;
        };
        case ("getname"): {
            private _cursorObject = cursorObject;
            if (_cursorObject isKindOf "Man") then {
                _unit = _cursorObject;
            };
        };
        default {
            _unit = _name call FUNC(parseNameToPlayer);
        };
    };
    CHECK(isNull _unit);

    ["ace_medical_treatment_fullHealLocal", _unit, _unit] call CBA_fnc_targetEvent;
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["teleport", {
    params ["_names"];
    private _units = [];

    CHECKRET(_names isEqualTo "",systemChat LLSTRING(chatCommands_falseArgument));

    _names = _names splitString "~";
    private _count = {
        _units pushBackUnique (_x call FUNC(parseNameToPlayer));
        true
    } count _names;

    if (objNull in _units) exitWith {
        systemChat LLSTRING(chatCommands_falseArgument);
    };

    if (_count isEqualTo 1) then {
        _units = [player , _units select 0];
    };

    _units params ["_unitA"];
    private _vehicle = objectParent _unitA;

    if (!isNull _vehicle && {speed _vehicle > 1} && {((getPos _vehicle) select 2) > 2}) exitWith {
        systemChat LLSTRING(chatCommands_teleportError);
    };
    if (!isNull _vehicle) then {
        [_unitA, ["Eject", _vehicle]] remoteExecCall ["action", _unitA];
    };

    [{
        params ["_unitA", "_unitB"];

        private _vehicle = objectParent _unitB;
        if (isNull _vehicle) then {
            _unitA setDir (getDir _unitB);
            _unitA setPos (_unitB getRelPos [-1, 0]);
        } else {
            private _moveInAnyResult = _unitA moveInAny _vehicle;
            if (!_moveInAnyResult) exitWith {systemChat LLSTRING(chatCommands_teleportError);};
        };
    }, _units, 0.5] call CBA_fnc_waitAndExecute;
}, "adminLogged"] call CBA_fnc_registerChatCommand;

["repair", {
    private _vehicle = objectParent player;

    if (isNull _vehicle) then {
        cursorObject setDamage 0;
    } else {
        _vehicle setDamage 0;
    };
}, "adminLogged"] call CBA_fnc_registerChatCommand;
