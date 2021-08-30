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

class Extended_InitPost_EventHandlers {
    class GVAR(miclic) {
        class GVAR(miclic_addIgniteAction) {
            clientInit = QUOTE(_this call FUNC(addIgniteMiclicAction));
        };
    };
};
