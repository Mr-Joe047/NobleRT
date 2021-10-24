#version 400 compatibility
#include "/programs/extensions.glsl"

/***********************************************/
/*       Copyright (C) Noble RT - 2021         */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

varying vec2 texCoords;

#include "/settings.glsl"
#include "/programs/common.glsl"
#include "/lib/fragment/brdf.glsl"
#include "/lib/atmospherics/atmosphere.glsl"
#include "/lib/atmospherics/volumetric.glsl"

/*
const int colortex8Format = RGBA16F;
*/

void main() {
    vec3 viewPos = getViewPos(texCoords);

    vec4 tex0 = texture(colortex0, texCoords);
    vec4 tex1 = texture(colortex1, texCoords);
    vec4 tex2 = texture(colortex2, texCoords);
    material mat = getMaterial(tex0, tex1, tex2);
    
    vec3 volumetricLighting = vec3(1.0);
    #if VL == 1
        volumetricLighting = computeVL(viewPos);
    #endif

    #if WHITE_WORLD == 1
		mat.albedo = vec3(1.0);
    #endif

    vec3 Lighting = mat.albedo;
    #if GI == 0
        if(!isSky(texCoords)) {
            vec3 normal = normalize(mat.normal.xyz);
            vec3 shadowmap = texture(colortex9, texCoords).rgb;
            vec3 lightmapColor = vec3(1.0);
    
            #if GI == 0
                vec2 lightMap = texture(colortex2, texCoords).zw;
                vec3 sky = texture(colortex7, projectSphere(normalize(viewToWorld(viewPos))) * ATMOSPHERE_RESOLUTION).rgb;
                lightmapColor = max(vec3(0.0), getLightmapColor(lightMap, sky));
            #endif

            vec3 illuminance = SUN_INTENSITY * atmosphereTransmittance(atmosRayPos, worldSunDir);
            Lighting = cookTorrance(viewPos, normal, sunDir, mat, lightmapColor, shadowmap, illuminance);
        }
    #endif

    /*DRAWBUFFERS:048*/
    gl_FragData[0] = vec4(max(vec3(0.0), Lighting), 1.0);
    gl_FragData[1] = vec4(mat.albedo, 1.0);
    gl_FragData[2] = vec4(volumetricLighting, 1.0);
}
