class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class MTS_Flag_Base: CBA_MiscItem {
        author = CSTRING(authors);
        scope = 0;
        descriptionShort = CSTRING(flagDescription);
        descriptionUse = CSTRING(flagDescription);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
    };

    class MTS_Flag_Red: MTS_Flag_Base {
        scope = 2;
        displayName = CSTRING(flagRedDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_red_item_icon.paa);
    };
    class MTS_Flag_Blue: MTS_Flag_Base {
        scope = 2;
        displayName = CSTRING(flagBlueDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_blue_item_icon.paa);
    };
    class MTS_Flag_Green: MTS_Flag_Base {
        scope = 2;
        displayName = CSTRING(flagGreenDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_green_item_icon.paa);
    };
    class MTS_Flag_Yellow: MTS_Flag_Base {
        scope = 2;
        displayName = CSTRING(flagYellowDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_yellow_item_icon.paa);
    };
};
