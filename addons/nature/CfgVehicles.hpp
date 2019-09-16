class CfgVehicles {
    class NonStrategic;
    class GVAR(bush_base): NonStrategic {
        author = "$STR_A3_Bohemia_Interactive";
        scope = 0;
        destrType = "DestructTent";
        icon = QPATHTOF(data\ui\mts_nature_ui_bush.paa);
        editorCategory = "EdCat_Environment";
        editorSubcategory = QGVAR(bush_faction);
    };

    class GVAR(plant_base): GVAR(bush_base) {
        icon = QPATHTOF(data\ui\mts_nature_ui_plant.paa);
        editorSubcategory = QGVAR(plant_faction);
    };

    class GVAR(tree_base): GVAR(bush_base) {
        destrType = "DestructTree";
        icon = QPATHTOF(data\ui\mts_nature_ui_tree.paa);
        editorSubcategory = QGVAR(tree_faction);
    };

    // Only for BWC
    class Rocks_base_F;
    class GVAR(rock_base): Rocks_base_F {
        author = "$STR_A3_Bohemia_Interactive";
        scope = 0;
        icon = QPATHTOF(data\ui\mts_nature_ui_rock.paa);
        accuracy = 1000;
    };

    #define BUSH(NAME,MODELPATH) \
    class NAME##: GVAR(bush_base) { \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
    }

    #define PLANT(NAME,MODELPATH) \
    class NAME##: GVAR(plant_base) { \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
    }

    #define TREE(NAME,MODELPATH) \
    class NAME##: GVAR(tree_base) { \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        displayName = CSTRING(NAME); \
        editorPreview = QPATHTOF(data\editorpreview\NAME.jpg); \
    }

    #define ROCK(NAME,MODELPATH) \
    class NAME##: GVAR(rock_base) { \
        scope = 2; \
        scopeCurator = 2; \
        model = MODELPATH##; \
        icon = QPATHTOF(data\ui\mts_nature_ui_rock.paa); \
        displayName = CSTRING(NAME); \
    }

    #include "CfgVehicles_Bush.hpp"
    #include "CfgVehicles_Plant.hpp"
    #include "CfgVehicles_Tree.hpp"
    #include "CfgVehicles_Rock.hpp"
};
