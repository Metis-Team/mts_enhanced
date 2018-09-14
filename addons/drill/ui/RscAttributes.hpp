class RscPicture;
class IGUIBack;

class RscTitles {
    class GVAR(StandStill) {
        idd = 800520;
        duration = 999999;
        class controls {
            class GVAR(StandStill_Picture) : RscPicture {
                idc = -1;
                text = QPATHTOF(ui\mts_StandStill.paa);
                x = "SafeZoneX + (1792 / 1920) * SafeZoneW";
                y = "SafeZoneY + (952 / 1080) * SafeZoneH";
                w = "(128 / 1920) * SafeZoneW";
                h = "(128 / 1080) * SafeZoneH";
            };
        };
        class controlsBackground {
            class GVAR(StandStill_Background): IGUIBack {
                idc = -1;
                colorBackground[] = {0, 0, 0, 0.3};
                x = "SafeZoneX + (1792 / 1920) * SafeZoneW";
                y = "SafeZoneY + (952 / 1080) * SafeZoneH";
                w = "(128 / 1920) * SafeZoneW";
                h = "(128 / 1080) * SafeZoneH";
            };
        };
    };

    class GVAR(AtEase) {
        idd = 800521;
        duration = 999999;
        class controls {
            class GVAR(AtEase_Picture) : RscPicture {
                idc = -1;
                text = QPATHTOF(ui\mts_AtEase.paa);
                x = "SafeZoneX + (1792 / 1920) * SafeZoneW";
                y = "SafeZoneY + (952 / 1080) * SafeZoneH";
                w = "(128 / 1920) * SafeZoneW";
                h = "(128 / 1080) * SafeZoneH";
            };
        };
        class controlsBackground {
            class GVAR(AtEase_Background): IGUIBack {
                idc = -1;
                colorBackground[] = {0, 0, 0, 0.3};
                x = "SafeZoneX + (1792 / 1920) * SafeZoneW";
                y = "SafeZoneY + (952 / 1080) * SafeZoneH";
                w = "(128 / 1920) * SafeZoneW";
                h = "(128 / 1080) * SafeZoneH";
            };
        };
    };
};
