class CfgVehicles {
    class ThingX;
    class GVAR(miclic_base): ThingX {
        author = CSTRING(authors);
        mapSize = 5.18;
        animated = 0;
        icon = "iconCrateOrd";
        accuracy = 0.2;
        editorCategory = "EdCat_Weapons";
        editorSubcategory = "EdSubcat_Explosives";
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
    };
    class GVAR(miclic): GVAR(miclic_base) {
        displayName = CSTRING(miclicDisplayName);
        editorPreview = "\A3\EditorPreviews_F_Exp\Data\CfgVehicles\Box_IED_Exp_F.jpg";
        scope = 2;
        scopeCurator = 2;
        model = "\A3\Weapons_F\Ammoboxes\Proxy_UsBasicExplosives.p3d";
        ace_cargo_canLoad = 1;
        ace_cargo_size = 4;
        ace_dragging_canCarry = 1;
        ace_dragging_carryPosition[] = {0, 1.2, 1};
        ace_dragging_canDrag = 1;
        ace_dragging_dragPosition[] = {0, 1.2, 0};
    };

    // Assault Breacher Vehicle / MiRPz
    class B_APC_Tracked_01_base_F;
    class B_APC_Tracked_01_CRV_F: B_APC_Tracked_01_base_F {
        class Attributes {
            class GVAR(mineClearing) {
                displayName = CSTRING(mineClearingDisplayName);
                tooltip = CSTRING(mineClearingTooltip);
                property = QGVAR(enableMineClearing);
                control = "Checkbox";
                defaultValue = "true";
                typeName = "BOOL";
                expression = QUOTE(_this setVariable [ARR_3(QQGVAR(enableMineClearing),_value,true)];); // Only run on server
            };
        };
    };
};
