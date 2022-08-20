#define MIN_DURATION 1
#define MAX_DURATION 60
#define TRAILING_DECIMALS 0

#define DEFAULT_GRASSCUTTER_DURATION 5

// Grasscutter: On/off
[
    QGVAR(grasscutter_enabled),
    "CHECKBOX",
    [LLSTRING(grasscutter), LLSTRING(grasscutter_tooltip)],
    [LELSTRING(main,category), LLSTRING(grasscutter_subCategory)],
    true,
    0
] call CBA_fnc_addSetting;

// Grasscutter: Size
[
    QGVAR(grasscutter_size),
    "LIST",
    [LLSTRING(grasscutter_size), LLSTRING(grasscutter_size_tooltip)],
    [LELSTRING(main,category), LLSTRING(grasscutter_subCategory)],
    [
        [0, 1],
        [LLSTRING(grasscutter_size_large), LLSTRING(grasscutter_size_medium)],
        1
    ],
    0
] call CBA_fnc_addSetting;

// Grasscutter: Time it takes to cut grass
[
    QGVAR(grasscutter_duration),
    "SLIDER",
    [LLSTRING(grasscutter_duration), LLSTRING(grasscutter_duration_tooltip)],
    [LELSTRING(main,category), LLSTRING(grasscutter_subCategory)],
    [MIN_DURATION, MAX_DURATION, DEFAULT_GRASSCUTTER_DURATION, TRAILING_DECIMALS],
    1 // Server setting
] call CBA_fnc_addSetting;
