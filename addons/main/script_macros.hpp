#define DEBUG_SYNCHRONOUS
#include "\x\cba\addons\main\script_macros_common.hpp"

#ifdef PATH_PREFIX
    #undef PATHTO_R
    #define PATHTO_R(var1) PATHTOF2_SYS(PATH_PREFIX,COMPONENT_C,var1)
    #undef PATHTO_T
    #define PATHTO_T(var1) PATHTOF_SYS(PATH_PREFIX,COMPONENT_T,var1)
    #undef PATHTO_M
    #define PATHTO_M(var1) PATHTOF_SYS(PATH_PREFIX,COMPONENT_M,var1)
    #undef PATHTO_S
    #define PATHTO_S(var1) PATHTOF_SYS(PATH_PREFIX,COMPONENT_S,var1)
    #undef PATHTO_C
    #define PATHTO_C(var1) PATHTOF_SYS(PATH_PREFIX,COMPONENT_C,var1)
    #undef PATHTO_F
    #define PATHTO_F(var1) PATHTO_SYS(PATH_PREFIX,COMPONENT_F,var1)

    #undef PATHTO
    #define PATHTO(var1) PATHTO_SYS(PATH_PREFIX,COMPONENT_F,var1)
    #undef PATHTOF
    #define PATHTOF(var1) PATHTOF_SYS(PATH_PREFIX,COMPONENT,var1)
    #undef PATHTOEF
    #define PATHTOEF(var1,var2) PATHTOF_SYS(PATH_PREFIX,var1,var2)

    #undef COMPILE_FILE
    #define COMPILE_FILE(var1) COMPILE_FILE_SYS(PATH_PREFIX,COMPONENT_F,var1)
    #undef COMPILE_FILE_CFG
    #define COMPILE_FILE_CFG(var1) COMPILE_FILE_CFG_SYS(PATH_PREFIX,COMPONENT_F,var1)
#endif

// Default versioning level
#define DEFAULT_VERSIONING_LEVEL 2

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#define DEFUNC(var1,var2) TRIPLES(DOUBLES(PREFIX,var1),fnc,var2)

#undef QFUNC
#undef QEFUNC
#define QFUNC(var1) QUOTE(DFUNC(var1))
#define QEFUNC(var1,var2) QUOTE(DEFUNC(var1,var2))

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

// Check
#define CHECK(CONDITION) if (CONDITION) exitWith {}
#define CHECKRET(CONDITION,RETURN) if (CONDITION) exitWith {RETURN;}

// Database
#define DB_CONNECT EFUNC(database,connectToDB)
#define DB_GET EFUNC(database,getData)
#define DB_SET EFUNC(database,setData)
#define DB_SETRET EFUNC(database,setDataReturn)
#define DB_TIME EFUNC(database,getTime)

#define ADDWEAPON(WEAPON,COUNT) class _xx_##WEAPON { \
    weapon = #WEAPON; \
    count = COUNT; \
}

#define ADDITEM(ITEM,COUNT) class _xx_##ITEM { \
    name = #ITEM; \
    count = COUNT; \
}

#define ADDMAGAZINE(MAGAZINE,COUNT) class _xx_##MAGAZINE { \
    magazine = #MAGAZINE; \
    count = COUNT; \
}

#define ADDBACKPACK(BACKPACK,COUNT) class _xx_##BACKPACK { \
    backpack = #BACKPACK; \
    count = COUNT; \
}

#include "\z\mts_enhanced\addons\main\script_debug.hpp"
