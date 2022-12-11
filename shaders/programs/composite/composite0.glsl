/***********************************************/
/*        Copyright (C) NobleRT - 2022         */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

#if GI == 1
    #if GI_FILTER == 1
        /* RENDERTARGETS: 5,11 */

        layout (location = 0) out vec4 color;
        layout (location = 1) out vec4 moments;

        #include "/include/fragment/atrous.glsl"
    #else
        /* RENDERTARGETS: 5 */

        layout (location = 0) out vec4 color;
    #endif
#else
    /* RENDERTARGETS: 4,2 */

    layout (location = 0) out vec4 color;
    layout (location = 1) out vec3 reflections;
#endif

#if GI == 0 && REFLECTIONS == 1
    #include "/include/fragment/brdf.glsl"
    
    #include "/include/atmospherics/celestial.glsl"

    #include "/include/fragment/raytracer.glsl"
    #include "/include/fragment/reflections.glsl"
#endif

void main() {
    #if GI == 0
        color = texture(colortex13, texCoords);

        #if REFLECTIONS == 1
            if(clamp(texCoords, vec2(0.0), vec2(REFLECTIONS_SCALE)) == texCoords) {
                vec2 scaledUv  = texCoords * rcp(REFLECTIONS_SCALE);

                if(!isSky(scaledUv)) {
                    vec3 viewPos = getViewPos0(scaledUv);
                    Material mat = getMaterial(scaledUv);
                    
                    #if REFLECTIONS_TYPE == 1
                        reflections = roughReflections(viewPos, mat);
                    #else
                        reflections = simpleReflections(viewPos, mat);
                    #endif
                }
            }
        #endif
    #else
        color = texture(colortex5, texCoords);

        #if GI_FILTER == 1
            aTrousFilter(color.rgb, colortex5, texCoords, moments, 3);
        #endif
    #endif
}
