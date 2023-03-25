class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

    class GVAR(folding_saw): CBA_MiscItem {
        scope = 2;
        author = CSTRING(authors);
        descriptionShort = CSTRING(foldingSawDescription);
        descriptionUse = CSTRING(foldingSawDescription);

        displayName = CSTRING(foldingSaw);
        picture = QPATHTOF(data\pictures\folding_saw_item.paa);

        GVAR(canCutBushes) = 1;

        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
    };
};
