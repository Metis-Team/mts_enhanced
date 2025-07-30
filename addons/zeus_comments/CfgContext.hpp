class zen_context_menu_actions {
    class GVAR(createComment) {
        displayName = STR_CREATE_COMMENT;
        icon = COMMENT_ICON;
        condition = QGVAR(enabled);
        statement = QUOTE([_position] call FUNC(openDialog));
        priority = 35;
    };
};
