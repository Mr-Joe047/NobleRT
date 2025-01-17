/***********************************************/
/*          Copyright (C) 2023 Belmu           */
/*       GNU General Public License V3.0       */
/***********************************************/

/*
    [Credits]:
        Jakemichie97 (https://twitter.com/jakemichie97?lang=en)
        Samuel (https://github.com/swr06)
        L4mbads (L4mbads#6227)
        SixthSurge (https://github.com/sixthsurge)
        
    [References]:
        Galvan, A. (2020). Ray Tracing Denoising. https://alain.xyz/blog/ray-tracing-denoising
        Dundr, J. (2018). Progressive Spatiotemporal Variance-Guided Filtering. https://cescg.org/wp-content/uploads/2018/04/Dundr-Progressive-Spatiotemporal-Variance-Guided-Filtering-2.pdf
*/

float gaussianVariance() {
    float variance = 0.0;

    for(int x = -1; x <= 1; x++) {
        for(int y = -1; y <= 1; y++) {
            float weight = gaussianDistribution2D(vec2(x, y), 1.0);
            variance    += texture(MOMENTS_BUFFER, texCoords + vec2(x, y) * pixelSize).z * weight;
        }
    }
    return variance;
}

const float aTrous[3] = float[3](1.0, 2.0 / 3.0, 1.0 / 6.0);
const float steps[5]  = float[5](
    ATROUS_STEP_SIZE * 0.0625,
    ATROUS_STEP_SIZE * 0.125,
    ATROUS_STEP_SIZE * 0.25,
    ATROUS_STEP_SIZE * 0.5,
    ATROUS_STEP_SIZE
);

float getATrousNormalWeight(vec3 normal, vec3 sampleNormal) {
    return pow(max0(dot(normal, sampleNormal)), NORMAL_WEIGHT_SIGMA);
}

float getATrousDepthWeight(float depth, float sampleDepth, vec2 dgrad, vec2 offset) {
    return exp(-abs(depth - sampleDepth) / (abs(DEPTH_WEIGHT_SIGMA * dot(dgrad, offset)) + 5e-3));
}

float getATrousLuminanceWeight(float luminance, float sampleLuminance, float variance) {
    return exp(-abs(luminance - sampleLuminance) / (LUMA_WEIGHT_SIGMA * variance + 1e-6));
}

void aTrousFilter(inout vec3 irradiance, inout vec4 moments, sampler2D tex, int passIndex) {
    Material material = getMaterial(texCoords);
    if(material.depth0 == 1.0) return;

    float totalWeight = 1.0, totalWeightSq = 1.0;
    vec2 stepSize     = steps[passIndex] * pixelSize;

    float frames = float(texture(DEFERRED_BUFFER, texCoords).a > 4.0);
    vec2 dgrad   = vec2(dFdx(material.depth0), dFdy(material.depth0));

    float centerLuma = luminance(irradiance);
    float variance   = gaussianVariance();

    moments = texture(MOMENTS_BUFFER, texCoords);

    for(int x = -1; x <= 1; x++) {
        for(int y = -1; y <= 1; y++) {
            if(all(equal(ivec2(x,y), ivec2(0)))) continue;

            vec2 offset       = vec2(x, y) * stepSize;
            vec2 sampleCoords = texCoords + offset;

            if(clamp01(sampleCoords) != sampleCoords) continue;

            Material sampleMaterial = getMaterial(sampleCoords);
            vec3 sampleIrradiance   = texelFetch(tex, ivec2(sampleCoords * viewSize), 0).rgb;

            float normalWeight = getATrousNormalWeight(material.normal, sampleMaterial.normal);
            float depthWeight  = getATrousDepthWeight(material.depth0, sampleMaterial.depth0, dgrad, offset);
            float lumaWeight   = mix(1.0, getATrousLuminanceWeight(centerLuma, luminance(sampleIrradiance), variance), frames);

            float weight   = clamp01(normalWeight * depthWeight * lumaWeight) * aTrous[abs(x)] * aTrous[abs(y)];
            irradiance    += sampleIrradiance * weight;
            totalWeight   += weight;
            totalWeightSq += weight * weight;
        }
    }
    irradiance /= totalWeight;
    moments.z  *= totalWeightSq;
}
