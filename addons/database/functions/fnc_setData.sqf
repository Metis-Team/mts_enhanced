/*
 *  Author: PhILoX
 *
 *  Description:
 *      Sets data in database without returned value (fire and forget)
 *
 *  Parameter(s):
 *      0: NUMBER - Session ID
 *      1: STRING - Statement
 *      2: ANY - Any value that the statement needs
 *      3: ...
 *
 *  Returns:
 *      None
 *
 *  Example:
 *      [1289, "deleteObject", 2] call mts_database_fnc_setData
 *
 */
#include "script_component.hpp"

CHECK(!GVAR(initialized) || isNil "_this" || !isServer);

private _query = [1];
_query append _this;
_query = _query joinString ":";
"extdb3" callExtension _query;
nil;
