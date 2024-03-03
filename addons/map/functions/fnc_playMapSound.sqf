#include "script_component.hpp"
/**
 *  Author: Timi007
 *
 *  Description:
 *      Globally plays a random unfold or pickup map sound.
 *
 *  Parameter(s):
 *      0: OBJECT - Sound source.
 *      1: STRING - Type of sound to play: "unfold" or "pickup".
 *
 *  Returns:
 *      STRING - Path of sound file which is played.
 *
 *  Example:
 *      [player, "pickup"] call mts_map_fnc_playMapSound
 *
 */

params [["_soundSource", objNull, [objNull]], ["_type", "unfold", [""]]];

CHECK(isNull _soundSource);

_type = toLower _type;
CHECK(_type isNotEqualTo "unfold" && _type isNotEqualTo "pickup");

private _soundFile = if (_type isEqualTo "unfold") then {
    format [QPATHTO_R(data\sounds\unfold_map_%1.ogg), (floor random 4) + 1]
} else {
    QPATHTO_R(data\sounds\pickup_map.ogg)
};

// Check if sound source is inside of a house
lineIntersectsSurfaces [
    getPosWorld _soundSource,
    getPosWorld _soundSource vectorAdd [0, 0, 50],
    _soundSource, objNull, true, 1, "GEOM", "NONE"
] select 0 params ["", "", "", "_house"];
private _isInside = _house isKindOf "House";

TRACE_3("play sound",_soundFile,_soundSource,_isInside);
playSound3D [_soundFile, _soundSource, _isInside, getPosASL _soundSource, 5, 1, 30];

_soundFile
