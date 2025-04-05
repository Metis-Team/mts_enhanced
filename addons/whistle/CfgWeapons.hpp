class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(FOX40): CBA_MiscItem {
        scope = 2;
        displayName = CSTRING(whistleDisplayName);
        author = CSTRING(authors);
        picture = QPATHTOF(data\ui\fox40_whistle_icon.paa);
        descriptionShort = CSTRING(description);
        descriptionUse = CSTRING(description);

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
