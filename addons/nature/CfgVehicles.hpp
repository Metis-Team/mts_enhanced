class CfgVehicles {
    class Thing;
    class Building;
    class Strategic;
    class NonStrategic: Building {
        class DestructionEffects;
    };
    class Fence;
    class Land_VASICore;
    class Fence_Ind: Fence {
        class DestructionEffects;
    };

    #define BUSH(NAME,MODELPATH) \
    class NAME##: Fence_Ind { \
        author = $STR_A3_Bohemia_Interactive; \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        icon = QPATHTOF(data\ui\mts_nature_ui_bush.paa); \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
        editorCategory = QGVAR(faction); \
        editorSubcategory = QGVAR(bush_faction); \
    }

    #define PLANT(NAME,MODELPATH) \
    class NAME##: Fence_Ind { \
        author = $STR_A3_Bohemia_Interactive; \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        icon = QPATHTOF(data\ui\mts_nature_ui_plant.paa); \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
        editorCategory = QGVAR(faction); \
        editorSubcategory = QGVAR(plant_faction); \
    }

    #define TREE(NAME,MODELPATH) \
    class NAME##: Fence_Ind { \
        author = $STR_A3_Bohemia_Interactive; \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        icon = QPATHTOF(data\ui\mts_nature_ui_tree.paa); \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
        editorCategory = QGVAR(faction); \
        editorSubcategory = QGVAR(tree_faction); \
    }

    #define ROCK(NAME,MODELPATH) \
    class NAME##: Fence_Ind { \
        author = $STR_A3_Bohemia_Interactive; \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        icon = QPATHTOF(data\ui\mts_nature_ui_rock.paa); \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
        editorCategory = QGVAR(faction); \
        editorSubcategory = QGVAR(rock_faction); \
    }

    #include "CfgVehicles_Bush.hpp"
    #include "CfgVehicles_Plant.hpp"
    #include "CfgVehicles_Tree.hpp"
    #include "CfgVehicles_Rock.hpp"
};
