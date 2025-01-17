/***********************************************/
/*          Copyright (C) 2023 Belmu           */
/*       GNU General Public License V3.0       */
/***********************************************/

/*
    const bool colortex4MipmapEnabled = true;
*/

#include "/settings.glsl"
#include "/include/utility/uniforms.glsl"

#include "/include/utility/rng.glsl"
#include "/include/utility/math.glsl"
#include "/include/utility/color.glsl"

#include "/include/atmospherics/constants.glsl"

#include "/include/utility/transforms.glsl"
#include "/include/utility/phase.glsl"

#include "/include/utility/material.glsl"

//////////////////////////////////////////////////////////
/*-------------- MISC UTILITY FUNCTIONS ----------------*/
//////////////////////////////////////////////////////////

const vec2 sunRotationData = vec2(cos(sunPathRotation * 0.01745329251994), -sin(sunPathRotation * 0.01745329251994));
float tmp = fract(worldTime / 24000.0 - 0.25);
float ang = (tmp + (cos(tmp * 3.14159265358979) * -0.5 + 0.5 - tmp) / 3.0) * 6.28318530717959;

vec3 sunPosNorm = vec3(-sin(ang), cos(ang) * sunRotationData);

bool isSky(vec2 coords)  { return texture(depthtex0, coords).r == 1.0;                          }
bool isHand(vec2 coords) { return linearizeDepth(texture(depthtex0, coords).r) < MC_HAND_DEPTH; }

const vec2 hiZOffsets[] = vec2[](
	vec2(0.0, 0.0 ),
	vec2(0.5, 0.0 ),
    vec2(0.5, 0.25)
);

float find2x2MinimumDepth(vec2 coords, int scale) {
    coords *= viewSize;

    return minOf(vec4(
        texelFetch(depthtex0, ivec2(coords)                      , 0).r,
        texelFetch(depthtex0, ivec2(coords) + ivec2(1, 0) * scale, 0).r,
        texelFetch(depthtex0, ivec2(coords) + ivec2(0, 1) * scale, 0).r,
        texelFetch(depthtex0, ivec2(coords) + ivec2(1, 1) * scale, 0).r
    ));
}
