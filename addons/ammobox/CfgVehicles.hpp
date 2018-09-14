class CfgVehicles {
    class Box_NATO_Equip_F;

    class MTS_Box_Ammo_Base: Box_NATO_Equip_F {
        author = "PhILoX, Timi007";
        scope = 0;
        scopeCurator = 0;
        class TransportWeapons {};
        class TransportMagazines {};
        class TransportItems {};
    };
    class MTS_Box_Ammo_Light: MTS_Box_Ammo_Base {
        displayName = CSTRING(Light_DisplayName);
        scope = 2;
        scopeCurator = 2;

        class TransportMagazines {
            ADDMAGAZINE(1Rnd_HE_Grenade_shell,10);
            ADDMAGAZINE(BWA3_DM25,8);
            ADDMAGAZINE(BWA3_DM32_Orange,2);
            ADDMAGAZINE(BWA3_DM32_Yellow,2);
            ADDMAGAZINE(BWA3_DM51A1,8);
            ADDMAGAZINE(BWA3_30Rnd_556x45_G36,32);
            ADDMAGAZINE(BWA3_30Rnd_556x45_G36_Tracer,8);
            ADDMAGAZINE(BWA3_30Rnd_556x45_G36_AP,16);
            ADDMAGAZINE(ACE_M84,8);
            ADDMAGAZINE(SmokeShellBlue,2);
            ADDMAGAZINE(SmokeShellGreen,2);
            ADDMAGAZINE(SmokeShellPurple,2);
            ADDMAGAZINE(SmokeShellRed,2);
            ADDMAGAZINE(BWA3_15Rnd_9x19_P8,16);
            ADDMAGAZINE(1Rnd_SmokeRed_Grenade_shell,4);
        };
    };

    class MTS_Box_Ammo_Heavy: MTS_Box_Ammo_Base {
        displayName = CSTRING(Heavy_DisplayName);
        scope = 2;
        scopeCurator = 2;

        class TransportMagazines {
            ADDMAGAZINE(hlc_100Rnd_762x51_B_MG3,6);
            ADDMAGAZINE(hlc_250Rnd_762x51_M_MG3,2);
            ADDMAGAZINE(BWA3_200Rnd_556x45,8);
        };
    };

    class MTS_Box_Ammo_Night: MTS_Box_Ammo_Base {
        displayName = CSTRING(Night_DisplayName);
        scope = 2;
        scopeCurator = 2;

        class TransportWeapons {
            ADDWEAPON(BWA3_P2A1,2);
        };
        class TransportMagazines {
            ADDMAGAZINE(ACE_Chemlight_HiOrange,16);
            ADDMAGAZINE(ACE_Chemlight_HiRed,16);
            ADDMAGAZINE(ACE_Chemlight_HiWhite,16);
            ADDMAGAZINE(ACE_Chemlight_HiYellow,16);
            ADDMAGAZINE(UGL_FlareRed_F,6);
            ADDMAGAZINE(UGL_FlareWhite_F,12);
            ADDMAGAZINE(UGL_FlareYellow_F,6);
            ADDMAGAZINE(BWA3_1Rnd_Flare_Multistar_Green,2);
            ADDMAGAZINE(BWA3_1Rnd_Flare_Multistar_Red,2);
            ADDMAGAZINE(BWA3_1Rnd_Flare_Singlestar_Green,4);
            ADDMAGAZINE(BWA3_1Rnd_Flare_Illum,12);
            ADDMAGAZINE(BWA3_1Rnd_Flare_Singlestar_Red,4);
        };
    };
};
