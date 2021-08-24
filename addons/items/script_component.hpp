#define COMPONENT items
#define COMPONENT_BEAUTIFIED Items
#include "\z\mts_enhanced\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS

#ifdef DEBUG_ENABLED_ITEMS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ITEMS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ITEMS
#endif

#include "\z\mts_enhanced\addons\main\script_macros.hpp"

#define PLACE_WAITING -1
#define PLACE_CANCEL 0
#define PLACE_APPROVE 1

#define MIN_HEIGHT -0.5
#define MAX_HEIGHT 2

#define MAX_DISTANCE 2
