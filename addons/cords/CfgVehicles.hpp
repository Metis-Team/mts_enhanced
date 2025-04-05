class CfgVehicles {
    class Man;
    class CAManBase: Man {
        class ACE_SelfActions {
            class ACE_Equipment {
                class GVAR(cords) {
                    displayName = CSTRING(cords);
                    icon = QPATHTOF(data\ui\mts_cords_ui_co.paa);
                    statement = "";
                    condition = QUOTE(GVAR(PBWLoaded) && {GVAR(enabled)} && {[_player] call FUNC(hasPBWUniform)});
                    exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};

                    class GVAR(cordsInf) {
                        displayName = CSTRING(inf);
                        icon = QPATHTOF(data\ui\mts_cords_ui_inf_co.paa);
                        statement = QUOTE([ARR_2(_player,'inf')] call FUNC(placeCordOnUniform));
                        condition = "true";
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};

                        class GVAR(cordsInfFA) {
                            displayName = CSTRING(fa);
                            icon = QPATHTOF(data\ui\mts_cords_ui_fa_co.paa);
                            statement = QUOTE([ARR_2(_player,'inf_fa')] call FUNC(placeCordOnUniform));
                            condition = "true";
                            exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};
                        };

                        class GVAR(cordsInfOA) {
                            displayName = CSTRING(oa);
                            icon = QPATHTOF(data\ui\mts_cords_ui_oa_co.paa);
                            statement = QUOTE([ARR_2(_player,'inf_oa')] call FUNC(placeCordOnUniform));
                            condition = "true";
                            exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};
                        };
                    };

                    class GVAR(cordsPz) {
                        displayName = CSTRING(pz);
                        icon = QPATHTOF(data\ui\mts_cords_ui_pz_co.paa);
                        statement = QUOTE([ARR_2(_player,'pz')] call FUNC(placeCordOnUniform));
                        condition = "true";
                        exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};

                        class GVAR(cordsInfFA) {
                            displayName = CSTRING(fa);
                            icon = QPATHTOF(data\ui\mts_cords_ui_fa_co.paa);
                            statement = QUOTE([ARR_2(_player,'pz_fa')] call FUNC(placeCordOnUniform));
                            condition = "true";
                            exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};
                        };

                        class GVAR(cordsInfOA) {
                            displayName = CSTRING(oa);
                            icon = QPATHTOF(data\ui\mts_cords_ui_oa_co.paa);
                            statement = QUOTE([ARR_2(_player,'pz_oa')] call FUNC(placeCordOnUniform));
                            condition = "true";
                            exceptions[] = {"isNotSwimming", "isNotInside", "isNotSitting", "isNotOnLadder", "isNotRefueling"};
                        };
                    };
                };
            };
        };
    };
};
