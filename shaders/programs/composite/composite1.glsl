/***********************************************/
/*        Copyright (C) NobleRT - 2022         */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

#if GI == 1 && GI_FILTER == 1
    /* RENDERTARGETS: 4,2,11 */

    layout (location = 0) out vec3 color;
    layout (location = 1) out vec3 fog;
    layout (location = 2) out vec4 moments;

    #include "/include/fragment/atrous.glsl"
#else
    /* RENDERTARGETS: 4,2 */

    layout (location = 0) out vec3 color;
    layout (location = 1) out vec3 fog;
#endif

#include "/include/fragment/brdf.glsl"
#include "/include/fragment/raytracer.glsl"
#include "/include/fragment/shadows.glsl"

#include "/include/atmospherics/celestial.glsl"
#include "/include/atmospherics/fog.glsl"

#include "/include/fragment/reflections.glsl"
#include "/include/fragment/water.glsl"

void main() {
    color = texture(colortex4, texCoords).rgb;

    Material mat = getMaterial(texCoords);
    vec3 coords  = vec3(texCoords, 0.0);

    vec3 viewPos0  = getViewPos0(texCoords);
    vec3 viewPos1  = getViewPos1(texCoords);
    vec3 scenePos0 = viewToScene(viewPos0);
    vec3 scenePos1 = viewToScene(viewPos1);

    float VdotL = dot(normalize(scenePos0), shadowLightVector);

    vec3 directIlluminance = vec3(0.0), skyIlluminance = vec3(0.0);
    
    #ifdef WORLD_OVERWORLD
        directIlluminance = texelFetch(colortex6, ivec2(0), 0).rgb;
        skyIlluminance    = texture(colortex6,  texCoords).rgb * RCP_PI;
    #endif

    bool  sky      = isSky(texCoords);
    float skyLight = 0.0;

    if(!sky) {
        skyLight = getSkyLightFalloff(mat.lightmap.y);

        //////////////////////////////////////////////////////////
        /*---------------- GLOBAL ILLUMINATION -----------------*/
        //////////////////////////////////////////////////////////

        #if GI == 1
            #if GI_FILTER == 1
                aTrousFilter(color, colortex4, texCoords * GI_RESOLUTION, moments, 4);
            #else
                color = texture(colortex4, texCoords * GI_RESOLUTION).rgb;
            #endif

            vec3 direct   = texture(colortex9,  texCoords * GI_RESOLUTION).rgb;
            vec3 indirect = texture(colortex10, texCoords * GI_RESOLUTION).rgb;
            
            color = direct + (indirect * color);
        #endif

        if(viewPos0.z != viewPos1.z) {
            //////////////////////////////////////////////////////////
            /*-------------------- REFRACTIONS ---------------------*/
            //////////////////////////////////////////////////////////

            #if REFRACTIONS == 1
                color     = refractions(viewPos0, mat, coords);
                scenePos1 = viewToScene(getViewPos1(coords.xy));
            #endif

            //////////////////////////////////////////////////////////
            /*---------------- FRONT TO BACK AIR_FOG -------------------*/
            //////////////////////////////////////////////////////////

            #ifdef WORLD_OVERWORLD
                if(isEyeInWater != 1 && mat.blockId == 1) {
                    #if WATER_FOG == 0
                        waterFog(color, scenePos0, scenePos1, VdotL, directIlluminance, skyIlluminance, skyLight);
                    #else
                        bool skyTranslucents = texture(depthtex1, coords.xy).r == 1.0;
                        volumetricWaterFog(color, scenePos0, scenePos1, VdotL, directIlluminance, skyIlluminance, skyLight, skyTranslucents);
                    #endif
                } else {
                    #if AIR_FOG == 1
                        volumetricFog(color, scenePos0, scenePos1, VdotL, directIlluminance, skyIlluminance, skyLight);
                    #else
                        groundFog(color, scenePos0, directIlluminance, skyIlluminance, skyLight, sky);
                    #endif
                }
            #endif
        }
    
        //////////////////////////////////////////////////////////
        /*-------------------- REFLECTIONS ---------------------*/
        //////////////////////////////////////////////////////////

        #if GI == 0
            #if SPECULAR == 1
                vec3 visibility = texture(colortex3, coords.xy).rgb;
                #ifdef SUNLIGHT_LEAKING_FIX
                    visibility *= float(mat.lightmap.y > EPS);
                #endif

                color += computeSpecular(mat.normal, -normalize(viewPos0), shadowVec, mat) * directIlluminance * visibility;
            #endif

            #if REFLECTIONS == 1
                color += texture(colortex2, texCoords * REFLECTIONS_RESOLUTION).rgb;
            #endif
        #endif
    } else {
        skyLight = 1.0;
    }

    //////////////////////////////////////////////////////////
    /*---------------- EYE TO FRONT AIR_FOG ----------------*/
    //////////////////////////////////////////////////////////

    #ifdef WORLD_OVERWORLD
        if(isEyeInWater == 1) {
            #if WATER_FOG == 0
                waterFog(color, gbufferModelViewInverse[3].xyz, scenePos0, VdotL, directIlluminance, skyIlluminance, skyLight);
            #else
                volumetricWaterFog(color, gbufferModelViewInverse[3].xyz, scenePos0, VdotL, directIlluminance, skyIlluminance, skyLight, sky);
            #endif
        } else {
            #if AIR_FOG == 1
                volumetricFog(color, gbufferModelViewInverse[3].xyz, scenePos0, VdotL, directIlluminance, skyIlluminance, skyLight);
            #else
                groundFog(color, gbufferModelViewInverse[3].xyz, directIlluminance, skyIlluminance, skyLight, sky);
            #endif
        }
    #endif
}
