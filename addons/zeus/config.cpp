#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"mts_main", "zen_custom_modules", "zen_dialog", "zen_common", "ace_medical", "ace_zeus"};
        author = "";
        authors[] = {"PhILoX", "Timi007"};
        VERSION_CONFIG;
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgAmmo.hpp"

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
