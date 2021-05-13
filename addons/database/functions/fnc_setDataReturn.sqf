#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Sets data in database with returned value
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
 *      [1289, "insertSomething", "Somehting", "to", "insert"] call mts_database_fnc_setDataReturn
 *
 */

CHECK(!GVAR(initialized) || isNil "_this" || !isServer);

private _query = [0];
_query append _this;
_query = _query joinString ":";
private _return = parseSimpleArray ("extdb3" callExtension _query);
((_return select 1) select 0)
