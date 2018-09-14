/**
 *  Author: PhILoX
 *
 *  Description:
 *      Get data from database
 *
 *  Parameter(s):
 *      0: NUMBER - Session ID
 *      1: STRING - Statement
 *      2: ANY - Any value that the statement needs
 *      3: ...
 *
 *  Returns:
 *      ANY - return of protocol
 *
 *  Example:
 *      [1289, "getAllObjects"] call mts_database_fnc_getData
 *
 */
#include "script_component.hpp"

CHECK(!GVAR(initialized) || isNil "_this" || !isServer);

private _query = [0];
_query append _this;
_query = _query joinString ":";
private _return = parseSimpleArray ("extdb3" callExtension _query);

switch (_return select 0) do {
    case 0 : {ERROR(format[ARR_2("Database Error: %1",(_return select 1))]);};
    case 2 : {_return = (_return select 1) call FUNC(multiMsg);};
};
(_return select 1);
