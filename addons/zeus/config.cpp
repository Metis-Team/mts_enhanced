#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "mts_main",
            "zen_custom_modules",
            "zen_dialog",
            "zen_common",
            "zen_context_menu",
            "zen_modules",
            "ace_medical",
            "ace_zeus"
        };
        author = ECSTRING(main,authors);
        authors[] = {"PhILoX", "Timi007"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAmmo.hpp"
#include "Cfg3DEN.hpp"
#include "CfgVehicles.hpp"

class RscPicture;
class RscDisplayCurator {
    class Controls {
        class Watermark: RscPicture {
            text = "";
            colorText[] = {1,1,1,0};
            w = 0;
            h = 0;
        };
    };
};
