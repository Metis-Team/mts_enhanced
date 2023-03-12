class CfgWeapons {
    class CBA_MiscItem;
    class CBA_MiscItem_ItemInfo;

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
        GVAR(vehicle) = QGVAR(marker_yellow);
        GVAR(icon) = QPATHTOF(data\ui\icons\mts_marker_yellow_place_icon.paa);
        scope = 2;
        displayName = CSTRING(markerYellowDisplayName);
        picture = QPATHTOF(data\ui\pictures\mts_marker_yellow_item.paa);
    };
    class GVAR(marker_mines): GVAR(marker_base) {
        GVAR(vehicle) = QGVAR(marker_mines);
        GVAR(icon) = QPATHTOF(data\ui\icons\mts_marker_mines_place_icon.paa);
        scope = 2;
        displayName = CSTRING(markerMinesDisplayName);
        picture = QPATHTOF(data\ui\pictures\mts_marker_mines_item.paa);
    };
};
