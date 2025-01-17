/***********************************************/
/*          Copyright (C) 2023 Belmu           */
/*       GNU General Public License V3.0       */
/***********************************************/

#include "/include/common.glsl"

#if PRIMARY_CLOUDS == 0 && SECONDARY_CLOUDS == 0
    #include "/programs/discard.glsl"
#else

    #if defined STAGE_VERTEX

        #include "/include/atmospherics/atmosphere.glsl"

        out vec3 skyIlluminance;
        out vec3 directIlluminance;

        void main() {
            gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            texCoords   = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;

            skyIlluminance    = sampleSkyIlluminanceSimple();
            directIlluminance = texelFetch(ILLUMINANCE_BUFFER, ivec2(0), 0).rgb;
        }

    #elif defined STAGE_FRAGMENT

        /* RENDERTARGETS: 7 */

        layout (location = 0) out vec4 clouds;

        in vec3 skyIlluminance;
        in vec3 directIlluminance;

        #include "/include/atmospherics/clouds.glsl"
        #include "/include/utility/sampling.glsl"

        void main() {
            clouds = vec4(0.0, 0.0, 0.0, 1.0);

            vec3 viewPos = getViewPos1(texCoords);

            vec3 cloudsRay   = mat3(gbufferModelViewInverse) * normalize(viewPos);
            vec4 cloudLayer0 = vec4(0.0, 0.0, 1.0, 1e6);
            vec4 cloudLayer1 = vec4(0.0, 0.0, 1.0, 1e6);

            #if PRIMARY_CLOUDS == 1
                cloudLayer0 = cloudsScattering(layer0, cloudsRay);
            #endif

            #if SECONDARY_CLOUDS == 1
                cloudLayer1 = cloudsScattering(layer1, cloudsRay);
            #endif

            float distanceToClouds = min(cloudLayer0.a, cloudLayer1.a);

            if(distanceToClouds > 1e-6) {
                vec2 scattering = cloudLayer1.rg * cloudLayer0.z + cloudLayer0.rg;
                clouds.rgb     += scattering.r   * directIlluminance;
                clouds.rgb     += scattering.g   * skyIlluminance;
                clouds.a        = cloudLayer0.b  * cloudLayer1.b;

                /* Reprojection */
                vec2 prevPos = reprojectClouds(viewPos, distanceToClouds).xy;
                vec4 history = textureCatmullRom(CLOUDS_BUFFER, prevPos);

                float resolutionScale = float(CLOUDS_SCALE < 100) + pow((CLOUDS_SCALE * 0.01) * 0.05 + 0.02, 0.35);

                vec2 pixelCenterDist = 1.0 - abs(2.0 * fract(prevPos * viewSize) - 1.0);
                float centerWeight   = sqrt(pixelCenterDist.x * pixelCenterDist.y) * 0.4 + 0.6;

                vec2  velocity       = (texCoords - prevPos) * viewSize;
                float velocityWeight = exp(-length(velocity)) * 0.8 + 0.2;

                float frameWeight = 1.0 / max(texture(DEFERRED_BUFFER, prevPos).w, 1.0);

                float weight = resolutionScale * centerWeight * velocityWeight * frameWeight * float(clamp01(prevPos) == prevPos);

                clouds = clamp16(mix(clouds, history, clamp01(weight)));
            }
        }
    #endif
#endif
