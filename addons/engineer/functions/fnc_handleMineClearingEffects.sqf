#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Description
 *
 *  Parameter(s):
 *      0: OBJECT - Mine clearing vehicle (ABV/MiRPz)
 *
 *  Returns:
 *      Nothing.
 *
 *  Example:
 *      _this call mts_engineer_fnc_handleMineClearingEffects
 *
 */

params [["_vehicle", objNull, [objNull]]];

private _pos = getPos _vehicle;

private _dustParticle = "#particlesource" createVehicleLocal _pos;
_dustParticle setParticleCircle [0, [0, 0, 0]];
_dustParticle setParticleRandom
[
    2,  // lifeTimeVar
    [0.5, 3, 0],  // positionVar
    [5, 5, 10],  // moveVelocityVar
    1,  // rotationVelocityVar
    0,  // sizeVar
    [0, 0, 0, 0.01],  // colorVar
    0, // randomDirectionPeriodVar
    0, // randomDirectionIntensityVar
    0  // angleVar
];
_dustParticle setDropInterval 0.01;

private _dirtParticle = "#particlesource" createVehicleLocal _pos;
_dirtParticle setParticleCircle [0, [0, 0, 0]];
_dirtParticle setParticleRandom
[
    2,
    [0.5, 3, 0],
    [15, 15, 5],
    0.1,
    0,
    [0, 0, 0, 0],
    0,
    0
];
_dirtParticle setDropInterval 0.5;

[{
    params ["_PFHArgs", "_PFHID"];
    _PFHArgs params ["_vehicle", "_dustParticle", "_dirtParticle"];

    if (!(_vehicle getVariable [QGVAR(mineClearingActive), false])) exitWith {
        [_PFHID] call CBA_fnc_removePerFrameHandler;

        deleteVehicle _dustParticle;
        deleteVehicle _dirtParticle;
    };

    private _vectorDir = vectorDirVisual _vehicle;

    _dustParticle setParticleParams
    [
        ["\A3\data_f\cl_basic", 1, 0, 1],
        "",
        "Billboard",
        1,
        4, // lifeTime
        [0, 4, -2.5], // pos3D
        [(_vectorDir select 0) * 50, (_vectorDir select 1) * 50, 22],  // moveVelocity
        0,  // rotationVelocity
        1.6,  // weight
        1,  // volume
        0.3,  // rubbing
        [2.2, 4, 6], // size
        [[0.060, 0.04, 0.02, 0.6], [0.050, 0.035, 0.02, 0.4], [0.030, 0.025, 0.015, 0.2]],  // color
        [1], // animationSpeed
        3, // randomDirectionPeriod
        3, // randomDirectionIntensity
        "", // onTimerScript
        "", // beforeDestroyScript
        _vehicle,
        0, // angle
        true, // onSurface
        0.1 // bounceOnSurface
    ];

    _dirtParticle setParticleParams
    [
        ["\A3\data_f\ParticleEffects\Universal\Mud", 1, 0, 1],
        "",
        "SpaceObject",
        1,
        10,
        [0, 4, -2.5],
        [(_vectorDir select 0) * 20, (_vectorDir select 1) * 20, 10],
        0,
        2,
        0.1,
        0.1,
        [0.2],
        [[1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]],
        [0.08],
        0,
        0,
        "",
        "",
        _vehicle,
        0,
        true,
        0.2
    ];
}, DIRT_SFX_UPDATE_INTERVAL, [_vehicle, _dustParticle, _dirtParticle]] call CBA_fnc_addPerFrameHandler;
