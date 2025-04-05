class CfgVehicles {
    class gm_tracked_Tank_base;
    class gm_Leopard1_base: gm_tracked_Tank_base {
        class Attributes;
    };
    class gm_BPz2_base: gm_Leopard1_base {
        class Attributes: Attributes {
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
