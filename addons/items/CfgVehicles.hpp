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
    class GVAR(flag_red_item): GVAR(item_base) {
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
    class GVAR(flag_blue_item): GVAR(item_base) {
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
    class GVAR(flag_green_item): GVAR(item_base) {
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
    class GVAR(flag_yellow_item): GVAR(item_base) {
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

    class ReammoBox_F;
    class GVAR(miclic): ReammoBox_F {
        author = CSTRING(authors);
        displayName = CSTRING(miclicDisplayName);
        editorPreview = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Box_IED_Exp_F.jpg";
        scope = 2;
        scopeCurator = 2;
        model = "\A3\Weapons_F\Ammoboxes\Proxy_UsBasicExplosives.p3d";
        icon = "iconCrateOrd";
        editorCategory = "EdCat_Supplies";
        maximumLoad = 0;
        class TransportMagazines {};
        class TransportWeapons {};
        class TransportItems {};
        ace_cargo_canLoad = 1;
        ace_cargo_size = 4;
        ace_dragging_canCarry = 0;
        ace_dragging_canDrag = 1;
    };
};
