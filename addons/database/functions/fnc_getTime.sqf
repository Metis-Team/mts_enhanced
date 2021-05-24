#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Returns the current time
 *
 *  Parameter(s):
 *      None
 *
 *  Returns:
 *      ARRAY - Time - [YY:MM:DD:HH:MM:SS]
 *
 *  Example:
 *      call mts_database_fnc_database_getTime
 *
 */

CHECK(!GVAR(initialized) || !isServer);

private _return = parseSimpleArray ("extdb3" callExtension "9:LOCAL_TIME");
(_return select 1);
