/***********************************************/
/*       Copyright (C) Noble RT - 2021       */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

vec3 computePTGI(in vec3 screenPos, bool isMetal) {
    vec3 illumination = vec3(0.0);
    vec3 weight = vec3(1.0);

    vec3 hitPos = screenPos;
    vec3 viewDir = -normalize(screenToView(screenPos));

    for(int i = 0; i < GI_BOUNCES; i++) {
        vec2 noise = uniformAnimatedNoise();

        /* Updating our position for the next bounce */
        vec3 normal = normalize(decodeNormal(texture2D(colortex1, hitPos.xy).xy));
        hitPos = screenToView(hitPos) + normal * EPS;

        vec3 tangent = normalize(cross(gbufferModelView[1].xyz, normal));
        mat3 TBN = mat3(tangent, cross(normal, tangent), normal);
        
        vec3 sampleDir = TBN * randomHemisphereDirection(noise);
        bool hit = raytrace(hitPos, sampleDir, GI_STEPS, blueNoise().r, hitPos);

        /* Thanks to Bálint#1673 and Jessie#7257 for helping me with the part below. */
        vec3 F0 = vec3(texture2D(colortex2, hitPos.xy).g);
        float roughness = texture2D(colortex2, hitPos.xy).r;

        vec3 microfacet = sampleGGXVNDF(-viewDir * TBN, noise.yx, roughness);
        vec3 reflected = reflect(viewDir, TBN * microfacet);

        vec3 H = normalize(viewDir + reflected);
        float NdotL = saturate(dot(normal, reflected));
        float NdotV = saturate(dot(normal, viewDir));
        float NdotH = saturate(dot(normal, H));
        float HdotL = saturate(dot(H, reflected));

        vec3 albedo = isMetal ? vec3(0.0) : texture2D(colortex0, hitPos.xy).rgb;
        vec3 specular = cookTorranceSpecular(NdotH, HdotL, NdotV, NdotL, roughness, F0);

        weight *= albedo;
        illumination += weight;
    }
    return max(vec3(EPS), illumination);
}
