#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Ignites the MICLIC clearing a path through a mine field. Execute on server only.
 *
 *  Parameter(s):
 *      0: OBJECT - Object which should act like a MICLIC.
 *      1: NUMBER - Effective mine clearing distance in meters (optional, default: 75m).
 *      2: NUMBER - First fuse delay before launching the rocket-projected explosive line charge (optional, default: 30 seconds).
 *      3: NUMBER - Second fuse delay before detonating the explosive line charge (optional, default: 5 seconds).
 *      4: NUMBER - Launch angle in degrees of the rocket attached to the explosive line charge (optional, default: 45°).
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      [this] call mts_items_fnc_igniteMiclic
 *
 */

#define DEFAULT_FUSE_DELAY 30
#define DEFAULT_CHARGE_FUSE_DELAY 5
#define DEFAULT_CLEARING_DISTANCE 75
#define DEFAULT_LAUNCH_ANGLE 45 // Degree

#define G 9.81
#define SPAWN_HEIGHT 0.5

params [
    ["_miclic", objNull, [objNull]],
    ["_effectiveClearingDistance", DEFAULT_CLEARING_DISTANCE, [0]],
    ["_fuseDelay", DEFAULT_FUSE_DELAY, [0]],
    ["_chargeFuseDelay", DEFAULT_CHARGE_FUSE_DELAY, [0]],
    ["_launchAngle", DEFAULT_LAUNCH_ANGLE, [0]]
];

CHECK(!isServer);

CHECKRET(isNull _miclic, ERROR("Given miclic object does not exist."));
if (_effectiveClearingDistance <= 0) then {
    WARNING("Effective clearing distance must be greater 0. Using default value.");
    _effectiveClearingDistance = DEFAULT_CLEARING_DISTANCE;
};
if (_fuseDelay < 0) then {
    WARNING("Fuse delay must be greater or equal 0. Using default value.");
    _fuseDelay = DEFAULT_FUSE_DELAY;
};
if (_chargeFuseDelay < 0) then {
    WARNING("Charge fuse delay must be greater or equal 0. Using default value.");
    _chargeFuseDelay = DEFAULT_CHARGE_FUSE_DELAY;
};
if (_launchAngle <= 0 || _launchAngle >= 90) then {
    WARNING("Launch angle cannot be <=0° or >=90°. Using default value.");
    _launchAngle = DEFAULT_LAUNCH_ANGLE;
};

[{
    params ["_miclic", "_effectiveClearingDistance", "_chargeFuseDelay", "_launchAngle"];

    [_miclic, false] remoteExecCall ["allowDamage", _miclic];

    private _miclicPosATL = getPosATL _miclic;
    private _miclicDir = getDir _miclic;

    private _smallRocketExplosive = createMine ["APERSMine", _miclicPosATL, [], 0];
    _smallRocketExplosive setDamage 1;

    private _rocketPos = [_miclicPosATL select 0, _miclicPosATL select 1, (_miclicPosATL select 2) + SPAWN_HEIGHT];
    private _rocket = createVehicle ["Land_BoreSighter_01_F", _rocketPos, [], 0, "CAN_COLLIDE"];
    _rocket setDir (_miclicDir - 90);
    _rocket enableSimulationGlobal false;

    private _ropeAnchor = createVehicle ["B_Static_Designator_01_F", getPosATL _miclic, [], 0, "CAN_COLLIDE"];
    _ropeAnchor attachTo [_miclic, [0, 0, 0]];
    _ropeAnchor hideObjectGlobal true;

    private _rope = ropeCreate [_ropeAnchor, [0, 0, 0], _rocket, [0, 0, 0], _effectiveClearingDistance + 5]; // +5 for buffer

    private _v0 = sqrt (((_effectiveClearingDistance - 1) * G) / sin (2 * _launchAngle)); // _effectiveClearingDistance - 1 for height difference buffer
    private _t0 = CBA_missionTime;
    // Top is y => 0°, right x => 90°, thus we need to subtract 90°, so that all formula using an angle are relativ from the x-axis.
    private _dir = 90 - _miclicDir;

    [{
        params ["_PFHArgs", "_PFHID"];
        _PFHArgs params ["_miclic", "_chargeFuseDelay", "_launchAngle", "_miclicPosATL", "_dir", "_t0", "_v0", "_rocket", "_rope", "_ropeAnchor"];

        private _t = CBA_missionTime - _t0;

        // Projectile motion without air resistance (to keep it simple)
        private _x = (_miclicPosATL select 0) + _t * _v0 * cos _launchAngle * cos _dir;
        private _y = (_miclicPosATL select 1) + _t * _v0 * cos _launchAngle * sin _dir;
        private _z = (_miclicPosATL select 2) + SPAWN_HEIGHT + _t * _v0 * sin _launchAngle - 0.5 * G * _t*_t;

        _rocket setPosATL [_x, _y, _z];

        if (_z < 0.01) exitWith {
            [_PFHID] call CBA_fnc_removePerFrameHandler;

            TRACE_1("Rope segments", ropeSegments _rope);

            _miclic addForce [_miclic vectorModelToWorld [random [-1000, 0, 1000], 1500, 650], [0, -1, 0]];

            [{
                params ["_miclic", "_dir", "_rocket", "_rope", "_ropeAnchor"];

                private _miclicPosATL = getPosATL _miclic;
                private _maxDistance = _miclic distance _rocket;

                // Detonate charge every 5 meters
                for [{private _i = 0}, {_i < _maxDistance}, {_i = _i + 5}] do {
                    private _pos = _miclicPosATL vectorAdd [_i * cos _dir, _i * sin _dir, 0];
                    private _charge = createMine ["DemoCharge_F", _pos, [], 0];
                    _charge setDamage 1;
                };

                // Place permanent dirt markers every 3 meters
                for [{private _i = 0}, {_i < _maxDistance}, {_i = _i + 3}] do {
                    private _pos = _miclicPosATL vectorAdd [_i * cos _dir, _i * sin _dir, 0];
                    private _dirt = createVehicle ["Land_DirtPatch_01_4x4_F", _pos, [], 0, "CAN_COLLIDE"];
                    _dirt setDir (getDir _miclic);
                    createVehicle ["Land_ClutterCutter_medium_F", getPosATL _dirt, [], 0, "CAN_COLLIDE"];
                };

                _miclic addForce [_miclic vectorModelToWorld [random [-1000, 0, 1000], -1000, -1500], [0, -1, 0]];

                ropeDestroy _rope;
                deleteVehicle _ropeAnchor;
                deleteVehicle _rocket;

                [_miclic, true] remoteExecCall ["ace_dragging_fnc_setCarryable", 0];

            }, [_miclic, _dir, _rocket, _rope, _ropeAnchor], _chargeFuseDelay] call CBA_fnc_waitAndExecute;
        };
    }, 0, [_miclic, _chargeFuseDelay, _launchAngle, _miclicPosATL, _dir, _t0, _v0, _rocket, _rope, _ropeAnchor]] call CBA_fnc_addPerFrameHandler;
}, [_miclic, _effectiveClearingDistance, _chargeFuseDelay, _launchAngle], _fuseDelay] call CBA_fnc_waitAndExecute;
