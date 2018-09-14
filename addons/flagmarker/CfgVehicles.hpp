class CfgVehicles {
    class Item_Base_F;

    class MTS_Flag_Item_Base: Item_Base_F {
        author = CSTRING(authors);
        scope = 0;
        scopeCurator = 0;
        editorCategory = "EdCat_Equipment";
        editorSubcategory = "EdSubcat_InventoryItems";
        vehicleClass = "Items";
        model = "\A3\Weapons_F\DummyItemHorizontal.p3d";
        class TransportItems {};
    };
    class MTS_Flag_Red_Item: MTS_Flag_Item_Base {
        author = CSTRING(authors);
        displayName = CSTRING(flagRedDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class MTS_Flag_Red {
                name = "MTS_Flag_Red";
                count = 1;
            };
        };
    };
    class MTS_Flag_Blue_Item: MTS_Flag_Item_Base {
        author = CSTRING(authors);
        displayName = CSTRING(flagBlueDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class MTS_Flag_Blue {
                name = "MTS_Flag_Blue";
                count = 1;
            };
        };
    };
    class MTS_Flag_Green_Item: MTS_Flag_Item_Base {
        author = CSTRING(authors);
        displayName = CSTRING(flagGreenDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class MTS_Flag_Green {
                name = "MTS_Flag_Green";
                count = 1;
            };
        };
    };
    class MTS_Flag_Yellow_Item: MTS_Flag_Item_Base {
        author = CSTRING(authors);
        displayName = CSTRING(flagYellowDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class MTS_Flag_Yellow {
                name = "MTS_Flag_Yellow";
                count = 1;
            };
        };
    };
};
