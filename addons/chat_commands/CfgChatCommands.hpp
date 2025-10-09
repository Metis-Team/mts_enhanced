class mts_chat_commands {
    // ACE
    class medic {
        statement = QUOTE(call FUNC(promoteToMedic));
        args = 1;
    };
    class doctor {
        statement = QUOTE(call FUNC(promoteToMedic));
        args = 2;
    };
    class eng {
        statement = QUOTE(call FUNC(promoteToEng));
        args = 1;
    };
    class adveng {
        statement = QUOTE(call FUNC(promoteToEng));
        args = 2;
    };
    class healall {
        statement = QUOTE(call FUNC(healAll));
    };
    class heal {
        statement = QUOTE(call FUNC(heal));
    };

    // Markers
    class markers {
        statement = QUOTE(call FUNC(markers));
    };

    // Zeus
    class zeus {
        statement = QUOTE(call FUNC(promoteToZeus));
    };

    // Misc11
    class teleport {
        statement = QUOTE(call FUNC(teleport));
    };
    class repair {
        statement = QUOTE(call FUNC(repair));
    };
};
