#define COMPONENT zeus
#define COMPONENT_BEAUTIFIED Zeus
#include "\z\mts_enhanced\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS

#ifdef DEBUG_ENABLED_ZEUS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ZEUS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ZEUS
#endif

#include "\z\mts_enhanced\addons\main\script_macros.hpp"

#define ZEUS_DISPLAY 312
#define PAUSE_MENU_DISPLAY 49

#define ZEUS_MAP_CTRL 50
#define ZEUS_WATERMARK_CTRL 15717

#define TARGET_AREA_LINE_COLOR [1, 0, 0, 1]
#define TARGET_AREA_LINE_W 10
#define TARGET_AREA_HEIGHT 5
#define TARGET_AREA_MAX_DISTANCE 1500

#define DEFAULT_ILLUM_DETONATION_HEIGHT "200"
#define MIN_ILLUM_DETONATION_HEIGHT 150

#define DEFAULT_TOT "90"
#define DEFAULT_DURATION "120"
