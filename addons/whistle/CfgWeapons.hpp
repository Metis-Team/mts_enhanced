class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class MTS_FOX40_Whistle: CBA_MiscItem {
        scope = 2;
        displayName = CSTRING(whistleDisplayName);
        picture = QPATHTOF(data\ui\fox40_whistle_icon.paa);
        descriptionShort = CSTRING(description);
        descriptionUse = CSTRING(description);
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
