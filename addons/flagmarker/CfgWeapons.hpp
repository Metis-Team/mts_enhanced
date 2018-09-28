class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(base): CBA_MiscItem {
        author = CSTRING(authors);
        scope = 0;
        descriptionShort = CSTRING(flagDescription);
        descriptionUse = CSTRING(flagDescription);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
    };

    class GVAR(red): GVAR(base) {
        scope = 2;
        displayName = CSTRING(flagRedDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_red_item_icon.paa);
    };
    class GVAR(blue): GVAR(base) {
        scope = 2;
        displayName = CSTRING(flagBlueDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_blue_item_icon.paa);
    };
    class GVAR(green): GVAR(base) {
        scope = 2;
        displayName = CSTRING(flagGreenDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_green_item_icon.paa);
    };
    class GVAR(yellow): GVAR(base) {
        scope = 2;
        displayName = CSTRING(flagYellowDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_yellow_item_icon.paa);
    };
};
