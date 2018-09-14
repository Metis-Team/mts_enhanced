class Extended_PreStart_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preStart));
    };
};

class Extended_PreInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_preInit));
    };
};

class Extended_PostInit_EventHandlers {
    class ADDON {
        init = QUOTE(call COMPILE_FILE(XEH_postInit));
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayCurator {
        GVAR(curatorDisplayOpened) = QUOTE(CHECK(!GVAR(enableACEUnconsciousIcon)); call FUNC(initDrawIconEH));
    };
};

class Extended_DisplayUnload_EventHandlers {
    class RscDisplayCurator {
        GVAR(curatorDisplayClosed) = QUOTE(CHECK(!isClass (configFile >> 'CfgPatches' >> 'acre_api')); [false] call acre_api_fnc_setSpectator;);
    };
};
