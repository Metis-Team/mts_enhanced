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

    class ThingX;
    class GVAR(miclic_base): ThingX {
        author = CSTRING(authors);
        mapSize = 5.18;
        animated = 0;
        icon = "iconCrateOrd";
        accuracy = 0.2;
        editorCategory = "EdCat_Supplies";
        vehicleClass = "Ammo";
        destrType = "DestructBuilding";
        explosionEffect = "BasicAmmoExplosion";
        class DestructionEffects {
            class Smoke2 {
                simulation = "particles";
                type = "AmmoSmokeParticles2";
                position = "";
                intensity = 1;
                interval = 1;
                lifeTime = 2;
            };
            class Bullets {
                simulation = "particles";
                type = "AmmoBulletCore";
                position = "";
                intensity = 1;
                interval = 1;
                lifeTime = 1.2;
            };
            class HouseDestr {
                simulation = "destroy";
                type = "DelayedDestructionAmmoBox";
                position = "";
                intensity = 1;
                interval = 1;
                lifeTime = 10;
            };
        };
        cost = 0;
        armor = 200;
        waterLinearDampingCoefY = 1;
        waterAngularDampingCoef = 0.1;
        scope = 1;
        ace_cargo_canLoad = 1;
        ace_dragging_canCarry = 0;
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
    };
    class GVAR(miclic): GVAR(miclic_base) {
        displayName = CSTRING(miclicDisplayName);
        editorPreview = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Box_IED_Exp_F.jpg";
        scope = 2;
        scopeCurator = 2;
        model = "\A3\Weapons_F\Ammoboxes\Proxy_UsBasicExplosives.p3d";
        ace_cargo_size = 4;
    };
};
