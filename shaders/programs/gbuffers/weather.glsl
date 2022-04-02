/***********************************************/
/*        Copyright (C) NobleRT - 2022         */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

#if defined STAGE_VERTEX
	#define WEATHER
	#include "/programs/gbuffers/gbuffers.vsh"

#elif defined STAGE_FRAGMENT
	/* RENDERTARGETS: 5 */

	layout (location = 0) out vec4 color;

	in vec2 texCoords;
	in vec4 vertexColor;
	uniform sampler2D colortex0;

	void main() {
		vec4 albedoTex = texture(colortex0, texCoords);
		if(albedoTex.a < 0.102) discard;

		color = vertexColor * albedoTex;
	}
#endif
