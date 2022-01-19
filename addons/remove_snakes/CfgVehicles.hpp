class CfgVehicles {
    class Animal;
    class Animal_Base_F: Animal {
        class EventHandlers;
    };

    class Snake_random_F: Animal_Base_F {
        class EventHandlers: EventHandlers {
            init = "deleteVehicle (_this select 0);";
        };
    };
};
