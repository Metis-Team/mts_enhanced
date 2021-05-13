#include "script_component.hpp"
/**
 *  Author: PhILoX
 *
 *  Description:
 *      Retrieves multipart messages from database
 *
 *  Parameter(s):
 *      0: String - Key from a open pipe
 *
 *  Returns:
 *       ANY - return of protocol
 *
 *  Example:
 *      ["1234"] call mts_database_fnc_multiMsg
 *
 */

CHECK(!GVAR(initialized) || !isServer);

params ["_key", ""];
CHECK(_key isEqualTo "");

private _return = "";
private "_pipe";
while {true} do {
    _pipe = "extdb3" callExtension format["5:%1",_key];
    If (_pipe isEqualTo "") exitWith {};
    _return = _return + _pipe;
};
parseSimpleArray _return;
