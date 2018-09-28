class CfgVehicles {
    class Animal;
    class Animal_Base_F: Animal {
        class EventHandlers;
    };
    class Snake_random_F: Animal_Base_F {
        scope = 0;
        class EventHandlers: EventHandlers {
            init = "";
        };
    };
    class Snake_vipera_random_F: Snake_random_F {
        scope = 0;
    };
};
