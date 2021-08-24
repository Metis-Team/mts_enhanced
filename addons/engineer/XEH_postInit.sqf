#include "script_component.hpp"

// Add miclic to adv towing script if it is available
if (isServer) then {
    private _towRules = missionNamespace getVariable [QUOTE(SA_TOW_RULES_OVERRIDE), []];
    if (_towRules isEqualTo []) then {
        _towRules = missionNamespace getVariable [QUOTE(SA_TOW_RULES), []];
    };
    CHECK(_towRules isEqualTo []);

    _towRules pushBack ["Car", "CAN_TOW", QGVAR(miclic)];
    _towRules pushBack ["Tank", "CAN_TOW", QGVAR(miclic)];

    SA_TOW_RULES_OVERRIDE = _towRules;
};
