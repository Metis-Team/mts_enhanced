#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "ace_common"};
        author = ECSTRING(main,authors);
        authors[] = {"Bix", "PhILoX", "Timi007", "Toma"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgMovesBasic.hpp"
#include "CfgEventHandlers.hpp"
#include "ui\RscAttributes.hpp"
