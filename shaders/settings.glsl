/***********************************************/
/*          Copyright (C) 2023 Belmu           */
/*       GNU General Public License V3.0       */
/***********************************************/

#define ABOUT 0 // [0 1]

//////////////////////////////////////////////////////////
/*---------------------- BUFFERS -----------------------*/
//////////////////////////////////////////////////////////

#define MAIN_BUFFER			colortex0
#define GBUFFERS_DATA		colortex1
#define REFLECTIONS_BUFFER	colortex2
#define SHADOWMAP_BUFFER	colortex3
#define DEFERRED_BUFFER		colortex4
#define ILLUMINANCE_BUFFER	colortex5
#define ATMOSPHERE_BUFFER	colortex6
#define CLOUDS_BUFFER		colortex7
#define HISTORY_BUFFER		colortex8
#define DIRECT_BUFFER		colortex9
#define INDIRECT_BUFFER		colortex10
#define MOMENTS_BUFFER		colortex11
#define LUT_BUFFER			colortex14
#define RASTER_BUFFER		colortex15

//////////////////////////////////////////////////////////
/*------------------------ MATH ------------------------*/
//////////////////////////////////////////////////////////

const float EPS = 1e-6;

const float HALF_PI = 1.57079632;
const float PI      = 3.14159265;
const float RCP_PI  = 0.31830988;
const float TAU     = 6.28318530;

const float GOLDEN_ANGLE = 2.39996322;

//////////////////////////////////////////////////////////
/*----------------- OPTIFINE CONSTANTS -----------------*/
//////////////////////////////////////////////////////////

#define DISCARD_HAND 0 // [0 1]

#ifndef MC_HAND_DEPTH
	#define MC_HAND_DEPTH 0.56
#endif

const float sunPathRotation     = -35.0; // [-90.0 -85.0 -80.0 -75.0 -70.0 -65.0 -60.0 -55.0 -50.0 -45.0 -40.0 -35.0 -30.0 -25.0 -20.0 -15.0 -10.0 -5.0 0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0]
const int   shadowMapResolution = 3072;  // [512 1024 2048 3072 4096 6144 8192 10240]
const float shadowDistance      = 128.0; // [64.0 128.0 256.0 512.0 1024.0]

//////////////////////////////////////////////////////////
/*---------------------- LIGHTING ----------------------*/
//////////////////////////////////////////////////////////

#define SUBSURFACE_SCATTERING 1 // [0 1]
#define MATERIAL_AO           1 // [0 1]
#define SPECULAR              1 // [0 1]

#define BLOCKLIGHT_TEMPERATURE 3000 // [1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3100 3200 3300 3400 3500 3600 3700 3800 3900 4000 4100 4200 4300 4400 4500 4600 4700 4800 4900 5000 5100 5200 5300 5400 5500 5600 5700 5800 5900 6000 6100 6200 6300 6400 6500 6600 6700 6800 6900 7000 7100 7200 7300 7400 7500 7600 7700 7800 7900 8000 8100 8200 8300 8400 8500 8600 8700 8800 8900 9000 9100 9200 9300 9400 9500 9600 9700 9800 9900 10000 10100 10200 10300 10400 10500 10600 10700 10800 10900 11000 11100 11200 11300 11400 11500 11600 11700 11800 11900 12000 12100 12200 12300 12400 12500 12600 12700 12800 12900 13000 13100 13200 13300 13400 13500 13600 13700 13800 13900 14000 14100 14200 14300 14400 14500 14600 14700 14800 14900 15000]
#define EMISSIVE_INTENSITY     1000

#define DIRECTIONAL_LIGHTMAP 1 // [0 1]
#define SUNLIGHT_LEAKING_FIX

#define HARDCODED_SSS             1
#define HARDCODED_SSS_VAL      0.85
#define HARDCODED_EMISSION        1
#define HARDCODED_EMISSION_VAL 0.70

//////////////////////////////////////////////////////////
/*------------------ AMBIENT OCCLUSION -----------------*/
//////////////////////////////////////////////////////////

#define AO        1 // [0 1]
#define AO_TYPE   2 // [0 1 2]
#define AO_FILTER 1 // [0 1]
#define AO_SCALE 50 // [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]

#define SSAO_SAMPLES   12 // [4 8 12 16 20]
#define SSAO_RADIUS  0.70 // [0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00]
#define SSAO_STRENGTH 1.3

#define RTAO_SAMPLES 2 // [2 4 6 8 10]
#define RTAO_STEPS  64 // [16 24 32 40 64]

#define GTAO_HORIZON_STEPS 4
#define GTAO_SLICES        2 // [1 2 3 4 5 6]
#define GTAO_RADIUS     1.00 // [0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.00]

//////////////////////////////////////////////////////////
/*---------------------- SHADOWS -----------------------*/
//////////////////////////////////////////////////////////

#define SHADOWS     1 // [0 1]
#define SHADOW_TYPE 1 // [0 1 2]

#define SHADOW_SAMPLES          8 // [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]
#define SHADOW_DISTORTION    0.88
#define SHADOW_DEPTH_STRETCH 0.25

#define NORMAL_SHADOW_BLUR_RADIUS 1.00

// Soft Shadows
#define BLOCKER_SEARCH_SAMPLES   8
#define BLOCKER_SEARCH_RADIUS 10.0
#define LIGHT_SIZE           100.0

//////////////////////////////////////////////////////////
/*-------------------- RAY TRACING ---------------------*/
//////////////////////////////////////////////////////////

#define HIZ_LOD_COUNT 4
#define HIZ_START_LOD 3
#define HIZ_STOP_LOD  0

#define RAY_DEPTH_TOLERANCE 0.5

#define BINARY_REFINEMENT 1 // [0 1]
#define BINARY_COUNT      6

#define TEMPORAL_DEPTH_WEIGHT_SIGMA 2.0

//////////////////////////////////////////////////////////
/*---------------- GLOBAL ILLUMINATION -----------------*/
//////////////////////////////////////////////////////////

#define GI               0 // [0 1]
#define SKY_CONTRIBUTION 1 // [0 1]

#define GI_FILTER                1 // [0 1]
#define GI_TEMPORAL_ACCUMULATION 1 // [0 1]
#define RENDER_MODE 			 0 // [0 1]

#define ATROUS_STEP_SIZE     16.0 // [1.0 2.0 4.0 6.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0]
#define NORMAL_WEIGHT_SIGMA 128.0 // [1.0 2.0 4.0 6.0 8.0 10.0 12.0 14.0 16.0 18.0 20.0 32.0 64.0 128.0]
#define DEPTH_WEIGHT_SIGMA    1.0 // [1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0]
#define LUMA_WEIGHT_SIGMA     4.0 // [1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 21.0 22.0 23.0 24.0 25.0 26.0 27.0 28.0 29.0 30.0 31.0 32.0 33.0 34.0 35.0 36.0 37.0 38.0 39.0 40.0 41.0 42.0 43.0 44.0 45.0 46.0 47.0 48.0 49.0 50.0 51.0 52.0 53.0 54.0 55.0 56.0 57.0 58.0 59.0 60.0 61.0 62.0 63.0 64.0 65.0 66.0 67.0 68.0 69.0 70.0 71.0 72.0 73.0 74.0 75.0 76.0 77.0 78.0 79.0 80.0 81.0 82.0 83.0 84.0 85.0 86.0 87.0 88.0 89.0 90.0 91.0 92.0 93.0 94.0 95.0 96.0 97.0 98.0 99.0 100.0]

#define GI_SAMPLES     1 // [1 2 3 4 5 6 7 8]
#define MAX_GI_BOUNCES 8 // [1 2 3 4 5 6 7 8 9 10 11 12 9999]
#define MAX_GI_STEPS  64 // [64 80]
#define GI_SCALE 	1.00 // [0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

#define MIN_ROULETTE_BOUNCES 0

//////////////////////////////////////////////////////////
/*------------- REFLECTIONS | REFRACTIONS --------------*/
//////////////////////////////////////////////////////////

#define REFLECTIONS         1 // [0 1]
#define REFLECTIONS_TYPE    1 // [0 1]
#define REFLECTIONS_SCALE 100 // [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]
#define REFRACTIONS         1 // [0 1]

const float hardCodedRoughness = 0.0; // 0.0 = OFF

#define SKY_FALLBACK
#define SSR_REPROJECTION 1 // [0 1]

#define ROUGH_SAMPLES        1
#define ROUGH_REFLECT_STEPS 40

#define SIMPLE_REFLECT_STEPS 64
#define REFRACT_STEPS        64

//////////////////////////////////////////////////////////
/*-------------------- ATMOSPHERICS --------------------*/
//////////////////////////////////////////////////////////

#define CELESTIAL_SIZE_MULTIPLIER 1 // [1 2 3 4]

#define ATMOSPHERE_SCALE   25 // [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]
#define SCATTERING_STEPS   16 // [8 12 16 20 24 28 32]
#define TRANSMITTANCE_STEPS 8 // [8 12 16 20 24 28 32]

#define PRIMARY_CLOUDS           1 // [0 1]
#define SECONDARY_CLOUDS         1 // [0 1]
#define CLOUDS_SCALE            50 // [10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]
#define CLOUDS_SCATTERING_STEPS 20 // [8 12 16 20 24 28 32]

#define CLOUDS_WIND_SPEED 5.0

#define CLOUDS_SHADOWS 			    0 // [0 1]
#define CLOUDS_SHADOWS_RESOLUTION 256 // [128 256 512 1024 2048]

#define CLOUDS_LAYER0_ALTITUDE   1000 // [100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2500 3000 3500 4000 4500 5000 5500 6000 6500 7000 7500 8000 9500 10000]
#define CLOUDS_LAYER0_THICKNESS  1000 // [100 200 300 400 500 600 700 800 900 1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000]
#define CLOUDS_LAYER0_COVERAGE     25 // [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]
#define CLOUDS_LAYER0_SWIRL        10 // [5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100]
#define CLOUDS_LAYER0_SCALE      6e-4
#define CLOUDS_LAYER0_SHAPESCALE 8e-4 
#define CLOUDS_LAYER0_FREQUENCY  2.00
#define CLOUDS_LAYER0_DENSITY    1.00
#define CLOUDS_LAYER0_OCTAVES       1

#define CLOUDS_LAYER1_ALTITUDE 7000.0
#define CLOUDS_LAYER1_THICKNESS 400.0
#define CLOUDS_LAYER1_COVERAGE   0.60
#define CLOUDS_LAYER1_SWIRL      0.50
#define CLOUDS_LAYER1_SCALE      5e-5
#define CLOUDS_LAYER1_SHAPESCALE 5e-5
#define CLOUDS_LAYER1_FREQUENCY  1.40
#define CLOUDS_LAYER1_DENSITY    0.05
#define CLOUDS_LAYER1_OCTAVES       1

#define AIR_FOG              1 // [0 1 2]
#define VL_SCATTERING_STEPS 16 // [4 8 12 16 20 24 28 32]

#define FOG_ALTITUDE  63.0 // [4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 21.0 22.0 23.0 24.0 25.0 26.0 27.0 28.0 29.0 30.0 31.0 32.0 33.0 34.0 35.0 36.0 37.0 38.0 39.0 40.0 41.0 42.0 43.0 44.0 45.0 46.0 47.0 48.0 49.0 50.0 51.0 52.0 53.0 54.0 55.0 56.0 57.0 58.0 59.0 60.0 61.0 62.0 63.0 64.0]
#define FOG_THICKNESS 65.0 // [30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0 90.0 95.0 100.0 105.0 110.0 115.0 120.0 125.0 130.0 135.0 140.0 145.0 150.0]
#define FOG_DENSITY   0.00 // [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

#define STARS_AMOUNT      0.10
#define STARS_BRIGHTNESS   2.0
#define STARS_MIN_TEMP  2500.0
#define STARS_MAX_TEMP 50000.0

//////////////////////////////////////////////////////////
/*----------------------- TERRAIN ----------------------*/
//////////////////////////////////////////////////////////

#define WHITE_WORLD 0 // [0 1]

#define RAIN_PUDDLES         1 // [0 1]
#define RAIN_PUDDLES_SIZE 0.35 // [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95]

#define RAIN_DIRECTION vec2(0.35, 0.1)

#define POM         1 // [0 1 2]
#define POM_LAYERS 64 // [32 64 128 256 512]
#define POM_DEPTH 0.5 // [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1.0]

// WATER

#define WATER_CAUSTICS               0 // [0 1]
#define WATER_CAUSTICS_STRENGTH   1.00 // [0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.00]
#define WATER_CAUSTICS_BLUR_RADIUS 0.3

#define WATER_OCTAVES    16 // [2 4 6 8 16 32 48]
#define WAVE_AMPLITUDE 0.80 // [0.00 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.00 2.10 2.20 2.30 2.40 2.50 2.60 2.70 2.80 2.90 3.00 3.10 3.20 3.30 3.40 3.50 3.60 3.70 3.80 3.90 4.00 4.10 4.20 4.30 4.40 4.50 4.60 4.70 4.80 4.90 5.00]
#define WAVE_STEEPNESS 0.60 // [0.00 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.00 2.10 2.20 2.30 2.40 2.50 2.60 2.70 2.80 2.90 3.00 3.10 3.20 3.30 3.40 3.50 3.60 3.70 3.80 3.90 4.00 4.10 4.20 4.30 4.40 4.50 4.60 4.70 4.80 4.90 5.00]
#define WAVE_LENGTH	      9 // [0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5 7 7.5 8 8.5 9 9.5 10]

#define WATER_FOG       1 // [0 1]
#define WATER_FOG_STEPS 8 // [4 8 16 32]

#define WATER_ABSORPTION_R 20 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]
#define WATER_ABSORPTION_G 10 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]
#define WATER_ABSORPTION_B 4  // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]

#define WATER_SCATTERING_R 4 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]
#define WATER_SCATTERING_G 8 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]
#define WATER_SCATTERING_B 6 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100]

//////////////////////////////////////////////////////////
/*-------------- CAMERA & POST-PROCESSING --------------*/
//////////////////////////////////////////////////////////

#define TAA                        1 // [0 1]
#define TAA_OFFCENTER_REJECTION 0.25 // [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define TAA_STRENGTH            0.99

#define DOF           0 // [0 1]
#define DOF_RADIUS 20.0 // [0.0 1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 21.0 22.0 23.0 24.0 25.0 26.0 27.0 28.0 29.0 30.0 31.0 32.0 33.0 34.0 35.0 36.0 37.0 38.0 39.0 40.0]
#define DOF_DEPTH     0 // [0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 38 40 42 44 46 48 50 52 54 56 58 60 62 64 128 256 512 1024]
#define DOF_SAMPLES  12 // [4 6 8 10 12 14 16]
#define DOF_ANGLE_SAMPLES (3 * DOF_SAMPLES)

#define BLOOM             1 // [0 1]
#define BLOOM_STRENGTH 0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

#define VIGNETTE             0 // [0 1]
#define VIGNETTE_STRENGTH 0.25 // [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50]

#define FILM_GRAIN             0 // [0 1]
#define FILM_GRAIN_STRENGTH 1.00 // [0.00 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.00]

#define SHARPEN             0 // [0 1]
#define SHARPEN_STRENGTH 1.00 // [0.00 0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00]

#define UNDERWATER_DISTORTION         1
#define WATER_DISTORTION_SPEED     0.65
#define WATER_DISTORTION_AMPLITUDE 0.40

//////////////////////////////////////////////////////////
/*------------------ CAMERA SETTINGS -------------------*/
//////////////////////////////////////////////////////////

#define EXPOSURE 2 // [0 1 2]
#define PURKINJE 1 // [0 1]

#define EXPOSURE_GROWTH 2.40
#define EXPOSURE_DECAY  0.25

const float calibration       = 12.5;  // Light meter calibration
const float sensorSensitivity = 100.0; // Sensor sensitivity

#if EXPOSURE == 2
	#define HISTOGRAM_BINS 64
	#define DEBUG_HISTOGRAM 0

	// Logarithmic scale
	const float minLuminance      = -8.0;
	const float maxLuminance      =  9.0;
	const float luminanceRange    = maxLuminance - minLuminance;
	const float rcpLuminanceRange = 1.0 / luminanceRange;

	const vec2 debugHistogramSize = vec2(320, 192);
#endif

#define FOCAL          24 // [1 2 5 10 14 20 24 28 35 50 70 80 85 100 135 200 300 400 500 600]
#define F_STOPS      16.0 // [1.0 1.2 1.4 2.0 2.8 4.0 5.6 8.0 11.0 16.0 22.0 32.0]
#define ISO           100 // [50 100 200 400 800 1600 3200 6400 12800 25600 51200]
#define SHUTTER_SPEED 125 // [4 5 6 8 10 15 20 30 40 50 60 80 100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000]

//////////////////////////////////////////////////////////
/*------------------- COLOR GRADING --------------------*/
//////////////////////////////////////////////////////////

#define ACES 0

#define TONEMAP 4 // [-1 0 1 2 3 4 5]
#define LUT     0 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]

#if TONEMAP == ACES
	// ACES Settings
	const float ACES_EPS = 0.00006103;

	// Glow module constants
	const float RRT_GLOW_GAIN = 0.05;
	const float RRT_GLOW_MID  = 0.08;

	// Red modifier constants
	const float RRT_RED_SCALE =  0.82;
	const float RRT_RED_PIVOT =  0.03;
	const float RRT_RED_HUE   =   0.0;
	const float RRT_RED_WIDTH = 135.0;

	const float RRT_SAT_FACTOR = 0.96;
	const float ODT_SAT_FACTOR = 0.93;

	const float DIM_SURROUND_GAMMA = 0.9811;
	const float ODT_DISPGAMMA      =    2.4;
	const float ODT_GAMMA_OFFSET   =  0.055;

	const float ODT_CINEMA_WHITE = 48.0;
	const float ODT_CINEMA_BLACK = (ODT_CINEMA_WHITE / 2400.0);
#endif

#define WHITE_POINT   6500
#define WHITE_BALANCE 6500 // [5000 5100 5200 5300 5400 5500 5600 5700 5800 5900 6000 6100 6200 6300 6400 6500 6600 6700 6800 6900 7000 7100 7200 7300 7400 7500 7600 7700 7800 7900 8000 8100 8200 8300 8400 8500 8600 8700 8800 8900 9000 9100 9200 9300 9400 9500 9600 9700 9800 9900 10000]

#define VIBRANCE   0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define SATURATION 0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define CONTRAST   0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define GAMMA      0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define GAIN       0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define LIFT       0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
