#version 400 compatibility

/***********************************************/
/*        Copyright (C) NobleRT - 2022         */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

in vec2 texCoords;

#define STAGE_FRAGMENT
#define WORLD_OVERWORLD

#define ATROUS_PASS_INDEX 4

#include "/include/common.glsl"
#include "/programs/deferred/atrous_pass.glsl"