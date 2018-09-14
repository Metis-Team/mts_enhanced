class CfgVehicles {
    class Item_Base_F;
    class MTS_FOX40_ItemWhistle: Item_Base_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(whistleDisplayName);
        author = CSTRING(authors);
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";
        class TransportItems {
            class MTS_FOX40_Whistle {
                name = "MTS_FOX40_Whistle";
                count = 1;
            };
        };
    };
};
