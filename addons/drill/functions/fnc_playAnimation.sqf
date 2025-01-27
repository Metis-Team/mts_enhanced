#include "script_component.hpp"
/**
 *  Author: PhILoX, Timi007, Toma
 *
 *  Description:
 *      Executes given animation.
 *
 *  Parameter(s):
 *      0: STRING - Animation name. ("mts_drill_StandStill", "mts_drill_AtEase", "mts_drill_Salute", or "mts_drill_FY")
 *
 *  Returns:
 *      Nothing
 *
 *  Example:
 *      ["mts_drill_StandStill"] call mts_drill_fnc_playAnimation
 *
 */

params [["_animName", "", [""]]];

private _player = call CBA_fnc_currentUnit;
private _currAnimState = animationState _player;
private _animationSequence = [];

TRACE_2("",_animName,_currAnimState);

if (_animName isEqualTo QGVAR(StandStill)) then {
    if (_currAnimState == "AmovPercMstpSnonWnonDnon") then {
        _animationSequence = [QGVAR(AmovPercMstpSnonWnonDnon_StandStill), QGVAR(StandStill)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutRsc [QGVAR(StandStill), "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(StandStill)) then {
        _animationSequence = [QGVAR(StandStill_AmovPercMstpSnonWnonDnon)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutText ["", "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(AtEase)) then {
        _animationSequence = [QGVAR(AtEase_StandStill), QGVAR(StandStill)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutText ["", "PLAIN"];
            QGVAR(UILayer) cutRsc [QGVAR(StandStill), "PLAIN"];
        };
    };
    if (_currAnimState == "AmovPercMstpSnonWnonDnon_Salute") then {
        _animationSequence = ["AmovPercMstpSnonWnonDnon_SaluteOut", QGVAR(AmovPercMstpSnonWnonDnon_StandStill), QGVAR(StandStill)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutRsc [QGVAR(StandStill), "PLAIN"];
        };
    };
};

if (_animName isEqualTo QGVAR(AtEase)) then {
    if (_currAnimState == "AmovPercMstpSnonWnonDnon") then {
        _animationSequence = [QGVAR(AmovPercMstpSnonWnonDnon_AtEase), QGVAR(AtEase)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutRsc [QGVAR(AtEase), "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(AtEase)) then {
        _animationSequence = [QGVAR(AtEase_AmovPercMstpSnonWnonDnon)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutText ["", "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(StandStill)) then {
        _animationSequence = [QGVAR(StandStill_AtEase), QGVAR(AtEase)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutText ["", "PLAIN"];
            QGVAR(UILayer) cutRsc [QGVAR(AtEase), "PLAIN"];
        };
    };
    if (_currAnimState == "AmovPercMstpSnonWnonDnon_Salute") then {
        _animationSequence = ["AmovPercMstpSnonWnonDnon_SaluteOut", QGVAR(AmovPercMstpSnonWnonDnon_AtEase), QGVAR(AtEase)];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutRsc [QGVAR(AtEase), "PLAIN"];
        };
    };
};

if (_animName isEqualTo QGVAR(FY)) then {
    if (_currAnimState == "AmovPercMstpSnonWnonDnon") then {
        _animationSequence = [QGVAR(FY)];
    };
};

if (_animName isEqualTo QGVAR(Salute)) then {
    if (_currAnimState == QGVAR(StandStill)) then {
        _animationSequence = [QGVAR(StandStill_AmovPercMstpSnonWnonDnon), "AmovPercMstpSnonWnonDnon_SaluteIn"];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutText ["", "PLAIN"];
        };
    };
    if (_currAnimState == QGVAR(AtEase)) then {
        _animationSequence = [QGVAR(AtEase_AmovPercMstpSnonWnonDnon), "AmovPercMstpSnonWnonDnon_SaluteIn"];

        if (GVAR(UIEnabled)) then {
            QGVAR(UILayer) cutText ["", "PLAIN"];
        };
    };
};

TRACE_1("Animation Sequence",_animationSequence);

{
    // First entry is played with switchmove, other with playmove
    [_player, _x, [0, 2] select (_forEachIndex isEqualTo 0)] call ace_common_fnc_doAnimation;
} forEach _animationSequence;
