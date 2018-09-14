class CfgMovesBasic {
    class Actions {
        class NoActions;
        class CivilStandActions;

        class GVAR(StandStillActions): NoActions {
            turnL = "";
            turnR = "";
            stop = QGVAR(StandStill);
            StopRelaxed = QGVAR(StandStill);
            default = QGVAR(StandStill);
            PutDown = "";
            getOver = "";
            throwPrepare = "";
            throwGrenade[] = {"","Gesture"};
        };
        class GVAR(AtEaseActions): NoActions {
            turnL = "";
            turnR = "";
            stop = QGVAR(AtEase);
            StopRelaxed = QGVAR(AtEase);
            default = QGVAR(AtEase);
            PutDown = "";
            getOver = "";
            throwPrepare = "";
            throwGrenade[] = {"","Gesture"};
        };
    };
};

class CfgMovesMaleSdr: CfgMovesBasic {
    class StandBase;
    class States {
        class AmovPercMstpSnonWnonDnon: StandBase {
            ConnectTo[] += {QGVAR(AmovPercMstpSnonWnonDnon_StandStill),0.1,QGVAR(AmovPercMstpSnonWnonDnon_AtEase),0.1};
        };

        #define ANIMATION \
            head = "headDefault"; \
            aimingBody = "aimingNo"; \
            forceAim = 1; \
            static = 1;

        class CutSceneAnimationBase;

        class GVAR(Normal): AmovPercMstpSnonWnonDnon  {
            file = QPATHTOF(data\mts_Normal.rtm);
            speed = 0;
            ConnectTo[] = {};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 1;
            ANIMATION
        };
        class GVAR(AmovPercMstpSnonWnonDnon_StandStill): AmovPercMstpSnonWnonDnon  {
            actions = QGVAR(StandStillActions);
            file = QPATHTOF(data\mts_Normal_StandStill.rtm);
            speed = 1;
            ConnectTo[] = {QGVAR(StandStill),0.1};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 0;
        };
        class GVAR(StandStill_AmovPercMstpSnonWnonDnon): GVAR(AmovPercMstpSnonWnonDnon_StandStill)  {
            actions = "CivilStandActions";
            file = QPATHTOF(data\mts_StandStill_Normal.rtm);
            ConnectTo[] = {"AmovPercMstpSnonWnonDnon",0.1};
            InterpolateTo[] = {"Unconscious",0.01};
        };
        class GVAR(AmovPercMstpSnonWnonDnon_AtEase): AmovPercMstpSnonWnonDnon  {
            actions = QGVAR(AtEaseActions);
            file = QPATHTOF(data\mts_Normal_AtEase.rtm);
            speed = 1;
            ConnectTo[] = {QGVAR(AtEase),0.1};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 0;
        };
        class GVAR(AtEase_AmovPercMstpSnonWnonDnon): GVAR(AmovPercMstpSnonWnonDnon_AtEase)  {
            actions = "CivilStandActions";
            file = QPATHTOF(data\mts_AtEase_Normal.rtm);
            ConnectTo[] = {"AmovPercMstpSnonWnonDnon",0.1};
            InterpolateTo[] = {"Unconscious",0.01};
        };
        class GVAR(StandStill): AmovPercMstpSnonWnonDnon  {
            actions = QGVAR(StandStillActions);
            file = QPATHTOF(data\mts_StandStill.rtm);
            speed = 0;
            ConnectTo[] = {QGVAR(StandStill_AmovPercMstpSnonWnonDnon),0.1,QGVAR(StandStill_AtEase),0.1};
            //ConnectTo[] = {};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 1;
            ANIMATION
        };
        class GVAR(FY): AmovPercMstpSnonWnonDnon  {
            actions = "CivilStandActions";
            file = QPATHTOF(data\mts_FY.rtm);
            ConnectTo[] = {"AmovPercMstpSnonWnonDnon",0.1};
            InterpolateTo[] = {"Unconscious",0.01};
            speed = 1;
        };
        class GVAR(AtEase): AmovPercMstpSnonWnonDnon  {
            actions = QGVAR(AtEaseActions);
            file = QPATHTOF(data\mts_AtEase.rtm);
            speed = 0;
            ConnectTo[] = {QGVAR(AtEase_StandStill),0.1,QGVAR(AtEase_AmovPercMstpSnonWnonDnon),0.1};
            //ConnectTo[] = {};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 1;
            ANIMATION
        };
        class GVAR(AtEase_StandStill): AmovPercMstpSnonWnonDnon  {
            actions = QGVAR(StandStillActions);
            file = QPATHTOF(data\mts_AtEase_StandStill.rtm);
            speed = 1;
            ConnectTo[] = {QGVAR(StandStill),0.1};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 0;
        };
        class GVAR(StandStill_AtEase): AmovPercMstpSnonWnonDnon  {
            actions = QGVAR(AtEaseActions);
            file = QPATHTOF(data\mts_StandStill_AtEase.rtm);
            speed = 1;
            ConnectTo[] = {QGVAR(AtEase),0.1};
            InterpolateTo[] = {"Unconscious",0.01};
            looped = 0;
        };

    };
};
