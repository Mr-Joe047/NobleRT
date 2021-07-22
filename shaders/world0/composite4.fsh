/***********************************************/
/*       Copyright (C) Noble RT - 2021       */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

#version 400 compatibility

varying vec2 texCoords;

uniform vec3 previousCameraPosition;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferPreviousProjection;

#include "/settings.glsl"
#include "/lib/composite_uniforms.glsl"
#include "/lib/frag/dither.glsl"
#include "/lib/frag/noise.glsl"
#include "/lib/util/transforms.glsl"
#include "/lib/util/utils.glsl"
#include "/lib/util/worldTime.glsl"
#include "/lib/util/blur.glsl"
#include "/lib/material.glsl"
#include "/lib/lighting/brdf.glsl"
#include "/lib/util/reprojection.glsl"
#include "/lib/lighting/raytracer.glsl"
#include "/lib/lighting/ssr.glsl"

void main() {
    vec4 Result = texture2D(colortex0, texCoords);

    float VolumetricLighting = texture2D(colortex4, texCoords).a;
    #if VL == 1
        #if VL_BLUR == 1
            VolumetricLighting = bilateralBlur(colortex4).a;
        #endif
    #endif

    float depth = texture2D(depthtex0, texCoords).r;
    if(depth == 1.0) {
        gl_FragData[0] = Result;
        return;
    }
    vec3 viewPos = getViewPos();
    vec3 normal = normalize(texture2D(colortex1, texCoords).xyz * 2.0 - 1.0);

    float NdotV = max(dot(normal, normalize(-viewPos)), 0.0);
    float F0 = texture2D(colortex2, texCoords).g;

    #if SSR == 1
        bool isMetal = (F0 * 255.0) > 229.5;
        vec3 specColor = isMetal ? texture2D(colortex4, texCoords).rgb : vec3(F0);
        float roughness = texture2D(colortex2, texCoords).r;

        vec3 reflections;
        #if SSR_TYPE == 1
            reflections = prefilteredReflections(viewPos, normal, roughness);
        #else
            reflections = simpleReflections(viewPos, normal, NdotV, specColor);
        #endif

        vec3 DFG = Env_BRDF_Approx(specColor, roughness, NdotV);
        Result.rgb += mix(Result.rgb, reflections, DFG);
    #endif

    #if WATER_REFRACTION == 1
        if(getBlockId(texCoords) == 6) Result.rgb = simpleRefractions(Result.rgb, viewPos, normal, NdotV, F0);
    #endif

    Result.rgb += vec3(getDayTimeSunColor() * VolumetricLighting);

    /*DRAWBUFFERS:0*/
    gl_FragData[0] = Result;
}
