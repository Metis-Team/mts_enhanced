#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Adds unit knowledge, reveal and forget actions as modules and to the context menu.
 *
 *  Parameter(s):
 *      None.
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      call mts_zeus_fnc_moduleTargetKnowledge
 *
 */

["Metis", LLSTRING(AI_targetKnowledge),
    {
        params ["", "_attachedObj"];
        [_attachedObj] call FUNC(getTargetKnowledge);
    },
    "\a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa"
] call zen_custom_modules_fnc_register;

["Metis", LLSTRING(AI_forgetTarget),
    {
        params ["", "_attachedObj"];
        ["FORGET", [_attachedObj]] call FUNC(setTargetKnowledge);
    },
    "\a3\ui_f\data\igui\cfg\simpletasks\types\unknown_ca.paa"
] call zen_custom_modules_fnc_register;

["Metis", LLSTRING(AI_revealTarget),
    {
        params ["", "_attachedObj"];
        ["REVEAL", [_attachedObj]] call FUNC(setTargetKnowledge);
    },
    "\a3\ui_f\data\igui\cfg\simpletasks\types\scout_ca.paa"
] call zen_custom_modules_fnc_register;

private _parentTargetKnowledgeAction = [
   QGVAR(parentTargetKnowledge),
   LLSTRING(AI_knowledgeCategory),
   "\a3\ui_f\data\gui\rsc\rscdisplayegspectator\fps.paa",
   {},
   {
       params ["", "_objects"];
       !GVAR(moduleDestination_running) && ({(count crew _x) > 0} count _objects) > 0
   }
] call zen_context_menu_fnc_createAction;
private _parentAction = [_parentTargetKnowledgeAction, [], 0] call zen_context_menu_fnc_addAction;

private _targetKnowledgeAction = [
   QGVAR(targetKnowledge),
   LLSTRING(AI_targetKnowledge),
   "\a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa",
   {
       params ["", "_objects"];

       if (count _objects isNotEqualTo 1) exitWith {
           [LLSTRING(AI_tooManySelected)] call zen_common_fnc_showMessage;
       };

       [_objects select 0] call FUNC(getTargetKnowledge);
   },
   {
       params ["", "_objects"];
       count _objects isEqualTo 1
   }
] call zen_context_menu_fnc_createAction;
[_targetKnowledgeAction, _parentAction, 0] call zen_context_menu_fnc_addAction;

private _forgetTargetAction = [
   QGVAR(forgetTarget),
   LLSTRING(AI_forgetTarget),
   "\a3\ui_f\data\igui\cfg\simpletasks\types\unknown_ca.paa",
   {
       params ["", "_objects"];
       ["FORGET", _objects] call FUNC(setTargetKnowledge);
   }
] call zen_context_menu_fnc_createAction;
[_forgetTargetAction, _parentAction, 0] call zen_context_menu_fnc_addAction;

private _revealTargetAction = [
   QGVAR(revealTarget),
   LLSTRING(AI_revealTarget),
   "\a3\ui_f\data\igui\cfg\simpletasks\types\scout_ca.paa",
   {
       params ["", "_objects"];
       ["REVEAL", _objects] call FUNC(setTargetKnowledge);
   }
] call zen_context_menu_fnc_createAction;
[_revealTargetAction, _parentAction, 0] call zen_context_menu_fnc_addAction;
