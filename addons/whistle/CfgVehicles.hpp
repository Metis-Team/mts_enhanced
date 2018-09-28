class CfgVehicles {
    class Item_Base_F;
    class GVAR(FOX40_Item): Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(whistleDisplayName);
        author = CSTRING(authors);
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";
        class TransportItems {
            class GVAR(FOX40) {
                name = QGVAR(FOX40);
                count = 1;
            };
        };
    };
};
