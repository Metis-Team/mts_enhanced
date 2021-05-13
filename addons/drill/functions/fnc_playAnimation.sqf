#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007, Toma
 *
 *  Description:
 *      Executes given animation.
 *
 *  Parameter(s):
 *      0: STRING - Animation name
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["mts_drill_StandStill"] call mts_drill_fnc_playAnimation
 *
 */

params ["_animName"];

private _currAnimState = animationState player;
private _doAnimation = "";
private _doAnimationTwo = "";
TRACE_2("",_animName,_currAnimState);

if (_animName isEqualTo QGVAR(StandStill)) then {
    if (_currAnimState == "AmovPercMstpSnonWnonDnon") then {
        _doAnimation = QGVAR(AmovPercMstpSnonWnonDnon_StandStill);
        if (GVAR(UIEnabled)) then {
             cutRsc [QGVAR(StandStill),"PLAIN"];
        };
     };
    if (_currAnimState == QGVAR(StandStill)) then {
        _doAnimation = QGVAR(StandStill_AmovPercMstpSnonWnonDnon);
        if (GVAR(UIEnabled)) then {
            cutText ["", "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(AtEase)) then {
        _doAnimation = QGVAR(AtEase_StandStill);
        if (GVAR(UIEnabled)) then {
            cutText ["", "PLAIN"];
            cutRsc [QGVAR(StandStill),"PLAIN"];
        };
    };
    if (_currAnimState == "AmovPercMstpSnonWnonDnon_Salute") then {
        _doAnimation = "AmovPercMstpSnonWnonDnon_SaluteOut";
        _doAnimationTwo = QGVAR(AmovPercMstpSnonWnonDnon_StandStill);
        if (GVAR(UIEnabled)) then {
            cutRsc [QGVAR(StandStill),"PLAIN"];
        };
    };
};

if (_animName isEqualTo QGVAR(AtEase)) then {
    if (_currAnimState == "AmovPercMstpSnonWnonDnon") then {
        _doAnimation = QGVAR(AmovPercMstpSnonWnonDnon_AtEase);
        if (GVAR(UIEnabled)) then {
            cutRsc [QGVAR(AtEase),"PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(AtEase)) then {
        _doAnimation = QGVAR(AtEase_AmovPercMstpSnonWnonDnon);
        if (GVAR(UIEnabled)) then {
            cutText ["", "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(StandStill)) then {
        _doAnimation = QGVAR(StandStill_AtEase);
        if (GVAR(UIEnabled)) then {
            cutText ["", "PLAIN"];
            cutRsc [QGVAR(AtEase),"PLAIN"];
        };
    };
    if (_currAnimState == "AmovPercMstpSnonWnonDnon_Salute") then {
        _doAnimation = "AmovPercMstpSnonWnonDnon_SaluteOut";
        _doAnimationTwo = QGVAR(AmovPercMstpSnonWnonDnon_AtEase);
        if (GVAR(UIEnabled)) then {
            cutRsc [QGVAR(AtEase),"PLAIN"];
        };
    };
};

if (_animName isEqualTo QGVAR(FY)) then {
    if (_currAnimState == "AmovPercMstpSnonWnonDnon") then {
        _doAnimation = QGVAR(FY)};
};

if (_animName isEqualTo QGVAR(Salute)) then {
    if (_currAnimState == QGVAR(StandStill)) then {
        _doAnimation = QGVAR(StandStill_AmovPercMstpSnonWnonDnon);
        _doAnimationTwo = "AmovPercMstpSnonWnonDnon_SaluteIn";
        if (GVAR(UIEnabled)) then {
            cutText ["", "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(AtEase)) then {
        _doAnimation = QGVAR(StandStill_AmovPercMstpSnonWnonDnon);
        _doAnimationTwo = "AmovPercMstpSnonWnonDnon_SaluteIn";
        if (GVAR(UIEnabled)) then {
            cutText ["", "PLAIN"];
        };
    };
};


if !(_doAnimation isEqualTo "") then {
    [player,_doAnimation,2] call ace_common_fnc_doAnimation;
};

if !(_doAnimationTwo isEqualTo "") then {
    [player,_doAnimationTwo,0] call ace_common_fnc_doAnimation;
};
