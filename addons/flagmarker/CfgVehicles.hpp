class CfgVehicles {
    class Item_Base_F;

    class GVAR(item_base): Item_Base_F {
        author = CSTRING(authors);
        scope = 0;
        scopeCurator = 0;
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";
        class TransportItems {};
    };
    class GVAR(red_item): GVAR(item_base) {
        author = CSTRING(authors);
        displayName = CSTRING(flagRedDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class GVAR(red) {
                name = QGVAR(red);
                count = 1;
            };
        };
    };
    class GVAR(blue_item): GVAR(item_base) {
        author = CSTRING(authors);
        displayName = CSTRING(flagBlueDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class GVAR(blue) {
                name = QGVAR(blue);
                count = 1;
            };
        };
    };
    class GVAR(green_item): GVAR(item_base) {
        author = CSTRING(authors);
        displayName = CSTRING(flagGreenDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class GVAR(green) {
                name = QGVAR(green);
                count = 1;
            };
        };
    };
    class GVAR(yellow_item): GVAR(item_base) {
        author = CSTRING(authors);
        displayName = CSTRING(flagYellowDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class GVAR(yellow) {
                name = QGVAR(yellow);
                count = 1;
            };
        };
    };
};
