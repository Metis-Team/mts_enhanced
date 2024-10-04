#define COMPONENT engineer
#define COMPONENT_BEAUTIFIED Engineer
#include "\z\mts_enhanced\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS

#ifdef DEBUG_ENABLED_ENGINEER
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ENGINEER
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ENGINEER
#endif

#include "\z\mts_enhanced\addons\main\script_macros.hpp"

#define DEFAULT_FUSE_DELAY 45 // Seconds
#define DEFAULT_CHARGE_FUSE_DELAY 5 // Seconds
#define DEFAULT_CLEARING_DISTANCE 70 // Meters
#define DEFAULT_LAUNCH_ANGLE 45 // Launch angle of rocket in degree

#define G 9.81 // Gravitational acceleration
#define SPAWN_HEIGHT_OFFSET 0.5 // Spawn height of rocket relative to the miclic ATL position

#define MAX_MINE_CLEARING_SPEED 5 // km/h
#define DIRT_PATCH_UPDATE_INTERVAL 0.5 // Sec
#define DIRT_SFX_UPDATE_INTERVAL 2 // Sec
