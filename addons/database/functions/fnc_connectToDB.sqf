#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Connects to given database
 *
 *  Parameter(s):
 *      0: STRING - Database
 *      1: STRING - Protocol
 *
 *  Returns:
 *      ARRAY - [BOOLEAN, NUMBER] - [is connected, SessionID]
 *
 *  Example:
 *      ["armory", "armory.ini"] call mts_database_fnc_connectToDB
 *
 */

params [
    ["_database", "", [""]],
    ["_protocol", "", [""]]
];

CHECKRET(!isServer,[false]);

private _result = "extdb3" callExtension "9:VERSION";
if (_result isEqualTo "") exitWith {
    ERROR("No extDB3 extension loaded");
    [false];
};

if (!GVAR(initialized)) then {
    // reset the connection
    "extdb3" callExtension "9:RESET";
    LOG("Reset connection");
};

if ([toLower _database, toLower _protocol] in GVAR(connections)) exitWith {
    ERROR_2("The database '%1' and protocol '%2' are already initialized",_database,_protocol);
    [false];
};

_result = parseSimpleArray ("extdb3" callExtension "9:LOCK_STATUS");
if ((_result select 0) == 1) exitWith {
    ERROR("Communication to database is locked");
    [false];
};

_result = parseSimpleArray ("extdb3" callExtension format ["9:ADD_DATABASE:%1", _database]);
if ((_result select 0) isEqualTo 0) exitWith {
    ERROR_1("Cannot connect to database '%1'",_database);
    [false];
};

INFO_1("Connected to database '%1'",_database);

// Security
private _sessionID = round(random(999999));
while {_sessionID in GVAR(sessionIDs)} do {
    _sessionID = round(random(999999));
};
TRACE_1("Current session ID",_sessionID);

_result = parseSimpleArray ("extdb3" callExtension (format["9:ADD_DATABASE_PROTOCOL:%1:SQL_CUSTOM:%2:%3", _database, _sessionID, _protocol]));

if ((_result select 0) isNotEqualTo 1) exitWith {
    ERROR_1("Protocol '%1' not loaded",_protocol);
    [false];
};
INFO_1("Protocol '%1' loaded",_protocol);

GVAR(connections) pushBackUnique [toLower _database, toLower _protocol];
GVAR(sessionIDs) pushBackUnique _sessionID;
TRACE_2("",GVAR(connections),GVAR(sessionIDs));
GVAR(initialized) = true;
[true, _sessionID];
