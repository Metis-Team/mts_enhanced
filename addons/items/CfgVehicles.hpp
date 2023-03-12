class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class ADDON {
                    displayName = CSTRING(marker);
                    insertChildren = QUOTE(_this call FUNC(getActions));
                    icon = QPATHTOF(data\ui\icons\mts_marker_white_icon.paa);
                };
            };
        };
    };

    class FlagSmall_F;
    class GVAR(marker_yellow): FlagSmall_F {
        author = CSTRING(authors);
        displayName = CSTRING(markerYellowDisplayName);
    };

    class Land_Sign_MinesTall_English_F;
    class GVAR(marker_mines): Land_Sign_MinesTall_English_F {
        author = CSTRING(authors);
        displayName = CSTRING(markerMinesDisplayName);
    };

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

    class GVAR(marker_yellow_item): GVAR(item_base) {
        author = CSTRING(authors);
        displayName = CSTRING(markerYellowDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class GVAR(marker_yellow) {
                name = QGVAR(marker_yellow);
                count = 1;
            };
        };
    };
    class GVAR(marker_mines_item): GVAR(item_base) {
        author = CSTRING(authors);
        displayName = CSTRING(markerMinesDisplayName);
        scope = 2;
        scopeCurator = 2;
        class TransportItems {
            class GVAR(marker_mines) {
                name = QGVAR(marker_mines);
                count = 1;
            };
        };
    };
};
