#define COMPONENT zeus_plotting
#define COMPONENT_BEAUTIFIED Zeus Plotting
#include "\z\mts_enhanced\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_ZEUS_PLOTTING
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_ZEUS_PLOTTING
    #define DEBUG_SETTINGS DEBUG_SETTINGS_ZEUS_PLOTTING
#endif

#include "\z\mts_enhanced\addons\main\script_macros.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "defineResinclDesign.inc"

#define GETVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(var1),var2)]
#define GETMVAR(var1,var2) (missionNamespace GETVAR_SYS(var1,var2))

#define ICON "\a3\ui_f\data\map\markerbrushes\cross_ca.paa"
#define ICON_ANGLE 0
#define ICON_SCALE 1
#define MAP_ICON_SCALE 24
#define LINEWIDTH 5

#define CIRCLE_EDGES_MIN 12
#define CIRCLE_RESOLUTION 5

#define CUBOID_HEIGHT_THRESHOLD 0.1

#define MAX_RENDER_DISTANCE 3000
#define MAX_RENDER_DISTANCE_SQR 9000000

#define CAN_RENDER_ICON(CAMPOS,POS) (CAMPOS vectorDistanceSqr POS <= MAX_RENDER_DISTANCE_SQR)
#define CAN_RENDER_LINE(CAMPOS,POS1,POS2) ((CAMPOS vectorDistanceSqr POS1 <= MAX_RENDER_DISTANCE_SQR) || {CAMPOS vectorDistanceSqr POS2 <= MAX_RENDER_DISTANCE_SQR} || {[POS1, POS2, MAX_RENDER_DISTANCE, CAMPOS] call FUNC(isPosInCylinder)})
