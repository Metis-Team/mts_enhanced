class RscText;
class RscButton;
class RscListBox;
class IGUIBack;
class RscPicture;
class RscEdit;
class RscCheckBox;

class GVAR(dialog) {
    idd = IDD_EQUIPMENT;
    // Base classes
    class Button : RscButton {
        period = 0;
    };
    class Button_Image : Button {
        colorBackground[] = {0,0,0,0};
        colorBackgroundActive[] = {0,0,0,0};
    };
    class Text : RscText {
        style = 2;
        colorBackground[] = {0,0,0,0.5};
    };
    class Background_Image : IGUIBack {
        colorBackground[] = {0,0,0,0.5};
    };
    class ListBox : RscListBox {
        period = 0;
        colorSelectBackground2[] = {0.95,0.95,0.95,1};
    };

    class controls {
        // Header ----------------------------------------
        class Button_Arsenal : Button {
            idc = IDC_BUTTON_ARSENAL;
            text = "Arsenal";
            x = "SafeZoneX + (700 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(70 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE(_this call FUNC(openArsenal));
        };
        class Checkbox_Arsenal_Toggle : RscCheckBox {
            idc = IDC_CHECKBOX_ARSENAL;
            tooltip = "$STR_mts_Armory_checkbox_arsenalToggle_tooltip";
            x = "SafeZoneX + (780 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onCheckedChanged = QUOTE([ARR_2(QQGVAR(updateArsenal), [ARR_2(ctrlText IDC_TEXT_TITLE, (cbChecked (_this select 0)))])] call CBA_fnc_globalEvent);
        };
        class Text_Title : Text {
            idc = IDC_TEXT_TITLE;
            x = "SafeZoneX + (820 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(280 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Button_New_Equipment : Button_Image {
            idc = IDC_BUTTON_NEW_EQUIPMENT;
            tooltip = CSTRING(button_createEquipmentCategory_tooltip);
            x = "SafeZoneX + (1110 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE(\
                private _object = ((_this select 0) getVariable [ARR_2(QQGVAR(attachedObject),objNull)]);\
                closeDialog 0;\
                createDialog QQGVAR(newEquipment);\
                ((findDisplay IDD_NEW_EQUIPMENT) displayCtrl IDC_BUTTON_CREATE) setVariable [ARR_2(QQGVAR(attachedObject), _object)];\
            );
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_NEW_EQUIPMENT) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_NEW_EQUIPMENT) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_settings : Button_Image {
            idc = IDC_BUTTON_SETTINGS;
            tooltip = CSTRING(button_toggleSettings_tooltip);
            x = "SafeZoneX + (1150 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([false] call LINKFUNC(toggleSettings));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_SETTINGS) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_SETTINGS) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Exit : Button_Image {
            idc = -1;
            tooltip = CSTRING(button_exitDialog_tooltip);
            x = "SafeZoneX + (1190 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE((ctrlParent (_this select 0)) closeDisplay 1);
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EXIT) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EXIT) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        // Body headers  ----------------------------------------
        class Text_Loadouts : Text {
            idc = -1;
            text = CSTRING(text_loadout_title);
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (260 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Text_Backpacks : Text {
            idc = -1;
            text = CSTRING(text_backpack_title);
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (260 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        // Body loadout buttons ----------------------------------------
        class Button_Loadout_1 : Button {
            idc = IDC_LOADOUT_1;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (310 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_2 : Button {
            idc = IDC_LOADOUT_2;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (350 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_3 : Button {
            idc = IDC_LOADOUT_3;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (390 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_4 : Button {
            idc = IDC_LOADOUT_4;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (430 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_5 : Button {
            idc = IDC_LOADOUT_5;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (470 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_6 : Button {
            idc = IDC_LOADOUT_6;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (510 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_7 : Button {
            idc = IDC_LOADOUT_7;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (550 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_8 : Button {
            idc = IDC_LOADOUT_8;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (590 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_9 : Button {
            idc = IDC_LOADOUT_9;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (630 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_10 : Button {
            idc = IDC_LOADOUT_10;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (670 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_11 : Button {
            idc = IDC_LOADOUT_11;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (710 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        class Button_Loadout_12 : Button {
            idc = IDC_LOADOUT_12;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (750 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipLoadout));
        };
        // Body loadout configure buttons ----------------------------------------
        class Button_Loadout_Edit_1 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_1;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (310 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_1, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_1) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_1) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_2 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_2;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (350 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_2, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_2) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_2) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_3 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_3;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (390 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_3, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_3) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_3) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_4 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_4;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (430 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_4, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_4) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_4) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_5 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_5;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (470 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_5, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_5) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_5) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_6 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_6;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (510 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_6, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_6) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_6) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_7 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_7;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (550 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_7, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_7) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_7) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_8 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_8;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (590 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_8, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_8) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_8) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_9 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_9;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (630 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_9, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_9) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_9) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_10 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_10;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (670 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_10, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_10) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_10) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_11 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_11;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (710 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_11, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_11) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_11) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Loadout_Edit_12 : Button_Image {
            idc = IDC_BUTTON_EDIT_LOADOUT_12;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (750 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_LOADOUT_12, LOADOUT)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_12) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_LOADOUT_12) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        // Body backpacks buttons ----------------------------------------
        class Button_Backpack_1 : Button {
            idc = IDC_BACKPACK_1;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (310 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_2 : Button {
            idc = IDC_BACKPACK_2;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (350 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_3 : Button {
            idc = IDC_BACKPACK_3;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (390 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_4 : Button {
            idc = IDC_BACKPACK_4;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (430 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_5 : Button {
            idc = IDC_BACKPACK_5;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (470 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_6 : Button {
            idc = IDC_BACKPACK_6;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (510 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_7 : Button {
            idc = IDC_BACKPACK_7;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (550 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_8 : Button {
            idc = IDC_BACKPACK_8;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (590 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_9 : Button {
            idc = IDC_BACKPACK_9;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (630 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_10 : Button {
            idc = IDC_BACKPACK_10;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (670 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_11 : Button {
            idc = IDC_BACKPACK_11;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (710 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        class Button_Backpack_12 : Button {
            idc = IDC_BACKPACK_12;
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (750 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText (_this select 0))] call LINKFUNC(equipBackpack));
        };
        // Body backpacks configure buttons ----------------------------------------
        class Button_Backpack_Edit_1 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_1;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (310 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_1, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_1) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_1) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_2 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_2;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (350 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_2, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_2) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_2) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_3 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_3;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (390 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_3, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_3) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_3) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_4 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_4;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (430 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_4, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_4) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_4) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_5 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_5;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (470 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_5, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_5) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_5) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_6 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_6;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (510 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_6, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_6) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_6) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_7 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_7;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (550 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_7, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_7) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_7) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_8 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_8;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (590 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_8, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_8) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_8) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_9 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_9;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (630 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_9, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_9) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_9) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_10 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_10;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (670 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_10, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_10) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_10) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_11 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_11;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (710 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_11, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_11) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_11) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Button_Backpack_Edit_12 : Button_Image {
            idc = IDC_BUTTON_EDIT_BACKPACK_12;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (750 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(IDC_BACKPACK_12, BACKPACK)] call LINKFUNC(setEditArea));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_12) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_EDIT_BACKPACK_12) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        // Footer settings ----------------------------------------
        class Editbox_Equipment_Name : RscEdit {
            idc = IDC_EDITBOX_EQUIPMENT_NAME;
            tooltip = CSTRING(editbox_equipmentName_tooltip);
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (800 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Button_Save_Equipment : Button {
            idc = IDC_BUTTON_SAVE_EQUIPMENT;
            text = CSTRING(button_save_displayName);
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (800 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([(_this select 0)] call LINKFUNC(saveEquipment));
        };
        class Button_Delete_Equipment : Button_Image {
            idc = IDC_BUTTON_DELETE_EQUIPMENT;
            tooltip = CSTRING(button_deleteEquipment_tooltip);
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (800 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(((ctrlParent (_this select 0)) displayCtrl IDC_BUTTON_SAVE_EQUIPMENT), true)] call LINKFUNC(saveEquipment));
            onMouseEnter = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_DELETE_EQUIPMENT) ctrlSetBackgroundColor [ARR_4(0,0,0,1)]);
            onMouseExit = QUOTE(((ctrlParent (_this select 0)) displayCtrl IDC_BACKGROUND_DELETE_EQUIPMENT) ctrlSetBackgroundColor [ARR_4(0,0,0,0.5)]);
        };
        class Dropdown_Medic : ListBox {
            idc = IDC_LISTBOX_MEDIC;
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (840 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(75 / 1080) * SafeZoneH";
        };
        class Dropdown_Engineer : ListBox {
            idc = IDC_LISTBOX_ENGINEER;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (840 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(75 / 1080) * SafeZoneH";
        };
        class Editbox_Editors : RscEdit {
            idc = IDC_EDITBOX_EDITORS;
            tooltip = CSTRING(editbox_editors);
            x = "SafeZoneX + (775 / 1920) * SafeZoneW";
            y = "SafeZoneY + (925 / 1080) * SafeZoneH";
            w = "(370 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Button_Save_Editors : Button {
            idc = IDC_BUTTON_SAVE_EDITORS;
            text = CSTRING(button_save_displayName);
            x = "SafeZoneX + (995 / 1920) * SafeZoneW";
            y = "SafeZoneY + (965 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(QQGVAR(updateEditors),[ARR_2(ctrlText IDC_TEXT_TITLE, ctrlText IDC_EDITBOX_EDITORS)])] call CBA_fnc_serverEvent);
        };
    };
    class controlsBackground {
        class Background_1 : IGUIBack {
            idc = IDC_BACKGROUND_1;
            x = "SafeZoneX + (680 / 1920) * SafeZoneW";
            y = "SafeZoneY + (160 / 1080) * SafeZoneH";
            w = "(560 / 1920) * SafeZoneW";
            h = "(670 / 1080) * SafeZoneH";
        };
        class Background_2 : IGUIBack {
            idc = IDC_BACKGROUND_2;
            x = "SafeZoneX + (690 / 1920) * SafeZoneW";
            y = "SafeZoneY + (170 / 1080) * SafeZoneH";
            w = "(540 / 1920) * SafeZoneW";
            h = "(650 / 1080) * SafeZoneH";
        };
        // Header buttons ----------------------------------------
        class Background_New_Equipment : Background_Image {
            idc = IDC_BACKGROUND_NEW_EQUIPMENT;
            x = "SafeZoneX + (1110 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Icon_New_Equipment : RscPicture {
            idc = IDC_ICON_NEW_EQUIPMENT;
            text = QPATHTOF(data\newCategory.paa);
            x = "SafeZoneX + (1114 / 1920) * SafeZoneW";
            y = "SafeZoneY + (184 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Background_settings : Background_Image {
            idc = IDC_BACKGROUND_SETTINGS;
            x = "SafeZoneX + (1150 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Icon_Settings : RscPicture {
            idc = IDC_ICON_SETTINGS;
            text = QPATHTOF(data\settings.paa);
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (185 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Background_Exit : Background_Image {
            idc = IDC_BACKGROUND_EXIT;
            x = "SafeZoneX + (1190 / 1920) * SafeZoneW";
            y = "SafeZoneY + (180 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Icon_Exit : RscPicture {
            idc = -1;
            text = QPATHTOF(data\exit.paa);
            x = "SafeZoneX + (1195 / 1920) * SafeZoneW";
            y = "SafeZoneY + (185 / 1080) * SafeZoneH";
            w = "(20 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
        };
        // Loadouts background configure buttons ----------------------------------------
        class Background_Loadout_Edit_1 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_1;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (310 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_2 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_2;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (350 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_3 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_3;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (390 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_4 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_4;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (430 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_5 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_5;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (470 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_6 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_6;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (510 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_7 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_7;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (550 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_8 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_8;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (590 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_9 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_9;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (630 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_10 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_10;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (670 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_11 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_11;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (710 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Loadout_Edit_12 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_LOADOUT_12;
            x = "SafeZoneX + (935 / 1920) * SafeZoneW";
            y = "SafeZoneY + (750 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        // Loadouts icon configure buttons ----------------------------------------
        class Icon_Loadout_Edit_1 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_1;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (314 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_2 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_2;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (354 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_3 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_3;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (394 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_4 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_4;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (434 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_5 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_5;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (474 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_6 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_6;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (514 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_7 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_7;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (554 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_8 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_8;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (594 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_9 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_9;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (634 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_10 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_10;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (674 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_11 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_11;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (714 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Loadout_Edit_12 : RscPicture {
            idc = IDC_ICON_EDIT_LOADOUT_12;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (939 / 1920) * SafeZoneW";
            y = "SafeZoneY + (754 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        // Backpack background configure buttons ----------------------------------------
        class Background_Backpack_Edit_1 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_1;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (310 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_2 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_2;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (350 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_3 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_3;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (390 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_4 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_4;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (430 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_5 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_5;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (470 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_6 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_6;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (510 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_7 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_7;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (550 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_8 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_8;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (590 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_9 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_9;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (630 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_10 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_10;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (670 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_11 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_11;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (710 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Background_Backpack_Edit_12 : Background_Image {
            idc = IDC_BACKGROUND_EDIT_BACKPACK_12;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (750 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        // Backpacks icon configure buttons ----------------------------------------
        class Icon_Backpack_Edit_1 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_1;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (314 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_2 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_2;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (354 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_3 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_3;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (394 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_4 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_4;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (434 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_5 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_5;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (474 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_6 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_6;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (514 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_7 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_7;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (554 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_8 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_8;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (594 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_9 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_9;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (634 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_10 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_10;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (674 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_11 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_11;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (714 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        class Icon_Backpack_Edit_12 : RscPicture {
            idc = IDC_ICON_EDIT_BACKPACK_12;
            text = QPATHTOF(data\edit.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (754 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
        // Footer settings ----------------------------------------
        class Background_Delete_Equipment : Background_Image {
            idc = IDC_BACKGROUND_DELETE_EQUIPMENT;
            x = "SafeZoneX + (1155 / 1920) * SafeZoneW";
            y = "SafeZoneY + (800 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Icon_Delete_Equipment : RscPicture {
            idc = IDC_ICON_DELETE_EQUIPMENT;
            text = QPATHTOF(data\delete.paa);
            x = "SafeZoneX + (1159 / 1920) * SafeZoneW";
            y = "SafeZoneY + (804 / 1080) * SafeZoneH";
            w = "(22 / 1920) * SafeZoneW";
            h = "(22 / 1080) * SafeZoneH";
        };
    };
};
class GVAR(newEquipment) {
    idd = IDD_NEW_EQUIPMENT;
    // Base classes
    class Button : RscButton {
        period = 0;
    };

    class controls {
        class Editbox_Equipment_Name : RscEdit {
            idc = IDC_EDITBOX_EQUIPMENT;
            tooltip = CSTRING(editbox_equipmentName_tooltip);
            x = "SafeZoneX + (720 / 1920) * SafeZoneW";
            y = "SafeZoneY + (525 / 1080) * SafeZoneH";
            w = "(280 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Checkbox_Initialize_Equipment : RscCheckBox {
            idc = IDC_CHECKBOX_EQUIPMENT;
            tooltip = CSTRING(checkbox_initializeEquipmentCategory_tooltip);
            x = "SafeZoneX + (1010 / 1920) * SafeZoneW";
            y = "SafeZoneY + (525 / 1080) * SafeZoneH";
            w = "(30 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
        };
        class Button_Create_Equipment : Button {
            idc = IDC_BUTTON_CREATE;
            text = CSTRING(button_createEquipmentCategory_displayName);
            x = "SafeZoneX + (1050 / 1920) * SafeZoneW";
            y = "SafeZoneY + (525 / 1080) * SafeZoneH";
            w = "(150 / 1920) * SafeZoneW";
            h = "(30 / 1080) * SafeZoneH";
            onButtonClick = QUOTE([ARR_2(QQGVAR(createEquipment), [ARR_4(ctrlText IDC_EDITBOX_EQUIPMENT, [(getPlayerUID player)], cbChecked ((ctrlParent (_this select 0)) displayCtrl IDC_CHECKBOX_EQUIPMENT), (_this select 0) getVariable [ARR_2(QQGVAR(attachedObject), objNull)])])] call CBA_fnc_serverEvent; closeDialog 0);
        };
    };
    class controlsBackground {
        class Background : IGUIBack {
            idc = -1;
            x = "SafeZoneX + (710 / 1920) * SafeZoneW";
            y = "SafeZoneY + (515 / 1080) * SafeZoneH";
            w = "(500 / 1920) * SafeZoneW";
            h = "(50 / 1080) * SafeZoneH";
        };
    };
};
