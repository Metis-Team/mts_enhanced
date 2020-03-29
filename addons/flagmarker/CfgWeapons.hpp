class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(flag_base): CBA_MiscItem {
        author = CSTRING(authors);
        scope = 0;
        descriptionShort = CSTRING(flagDescription);
        descriptionUse = CSTRING(flagDescription);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 3;
        };
    };

    class GVAR(flag_red): GVAR(flag_base) {
        scope = 2;
        displayName = CSTRING(flagRedDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_red_item_icon.paa);
    };
    class GVAR(flag_blue): GVAR(flag_base) {
        scope = 2;
        displayName = CSTRING(flagBlueDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_blue_item_icon.paa);
    };
    class GVAR(flag_green): GVAR(flag_base) {
        scope = 2;
        displayName = CSTRING(flagGreenDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_green_item_icon.paa);
    };
    class GVAR(flag_yellow): GVAR(flag_base) {
        scope = 2;
        displayName = CSTRING(flagYellowDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_yellow_item_icon.paa);
    };


    class GVAR(marker_base): CBA_MiscItem {
        author = CSTRING(authors);
        scope = 0;
        descriptionShort = CSTRING(markerDescription);
        descriptionUse = CSTRING(markerDescription);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 5;
        };
    };

    class GVAR(marker_yellow): GVAR(marker_base) {
        scope = 2;
        displayName = CSTRING(markerYellowDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_red_item_icon.paa);
    };
    class GVAR(marker_mines): GVAR(marker_base) {
        scope = 2;
        displayName = CSTRING(markerMinesDisplayName);
        picture = QPATHTOF(data\ui\mts_flag_red_item_icon.paa);
    };
};
