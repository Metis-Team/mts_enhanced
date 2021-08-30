class CfgVehicles {
    class Animal_Base_F;
    class Snake_random_F: Animal_Base_F {
        class EventHandlers {
            init = "deleteVehicle (_this select 0);";
        };
    };
};
