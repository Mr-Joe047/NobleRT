/***********************************************/
/*       Copyright (C) Noble RT - 2021         */
/*   Belmu | GNU General Public License V3.0   */
/*                                             */
/* By downloading this content you have agreed */
/*     to the license and its terms of use.    */
/***********************************************/

#define ABOUT 0 // [0 1]

//////////////////////////////////////////////////////////
/*------------------------ MATH ------------------------*/
//////////////////////////////////////////////////////////

#define REC_709 vec3(0.2126, 0.7152, 0.0722)
#define EPS 1e-4

#define QUARTER_PI 0.78539816
#define HALF_PI    1.57079632
#define PI         3.14159265
#define TAU        6.28318530
#define INV_PI     0.31830988

#define GOLDEN_RATIO 1.61803398
#define GOLDEN_ANGLE 2.39996322

//////////////////////////////////////////////////////////
/*----------------- OPTIFINE CONSTANTS -----------------*/
//////////////////////////////////////////////////////////
const float sunPathRotation      = -40.0; // [-85.0 -80.0 -75.0 -70.0 -65.0 -60.0 -55.0 -50.0 -45.0 -40.0 -35.0 -30.0 -25.0 -20.0 -15.0 -10.0 -5.0 0.0 5.0 10.0 15.0 20.0 25.0 30.0 35.0 40.0 45.0 50.0 55.0 60.0 65.0 70.0 75.0 80.0 85.0]
const int noiseTextureResolution =   128;

const int shadowMapResolution =  3072; // [512 1024 2048 3072 4096 6144]
const float shadowDistance    = 256.0; // [64.0 128.0 256.0 512.0 1024.0]

//////////////////////////////////////////////////////////
/*---------------------- LIGHTING ----------------------*/
//////////////////////////////////////////////////////////

#define SUBSURFACE_SCATTERING 1 // [0 1]
#define MATERIAL_AO           1 // [0 1]
#define SPECULAR              1 // [0 1]

#define BLOCKLIGHT_TEMPERATURE   2700 // [1000 1100 1200 1300 1400 1500 1600 1700 1800 1900 2000 2100 2200 2300 2400 2500 2600 2700 2800 2900 3000 3100 3200 3300 3400 3500 3600 3700 3800 3900 4000 4100 4200 4300 4400 4500 4600 4700 4800 4900 5000 5100 5200 5300 5400 5500 5600 5700 5800 5900 6000 6100 6200 6300 6400 6500 6600 6700 6800 6900 7000 7100 7200 7300 7400 7500 7600 7700 7800 7900 8000 8100 8200 8300 8400 8500 8600 8700 8800 8900 9000 9100 9200 9300 9400 9500 9600 9700 9800 9900 10000 10100 10200 10300 10400 10500 10600 10700 10800 10900 11000 11100 11200 11300 11400 11500 11600 11700 11800 11900 12000 12100 12200 12300 12400 12500 12600 12700 12800 12900 13000 13100 13200 13300 13400 13500 13600 13700 13800 13900 14000 14100 14200 14300 14400 14500 14600 14700 14800 14900 15000 15100 15200 15300 15400 15500 15600 15700 15800 15900 16000 16100 16200 16300 16400 16500 16600 16700 16800 16900 17000 17100 17200 17300 17400 17500 17600 17700 17800 17900 18000 18100 18200 18300 18400 18500 18600 18700 18800 18900 19000 19100 19200 19300 19400 19500 19600 19700 19800 19900 20000 20100 20200 20300 20400 20500 20600 20700 20800 20900 21000 21100 21200 21300 21400 21500 21600 21700 21800 21900 22000 22100 22200 22300 22400 22500 22600 22700 22800 22900 23000 23100 23200 23300 23400 23500 23600 23700 23800 23900 24000 24100 24200 24300 24400 24500 24600 24700 24800 24900 25000 25100 25200 25300 25400 25500 25600 25700 25800 25900 26000 26100 26200 26300 26400 26500 26600 26700 26800 26900 27000 27100 27200 27300 27400 27500 27600 27700 27800 27900 28000 28100 28200 28300 28400 28500 28600 28700 28800 28900 29000 29100 29200 29300 29400 29500 29600 29700 29800 29900 30000 30100 30200 30300 30400 30500 30600 30700 30800 30900 31000 31100 31200 31300 31400 31500 31600 31700 31800 31900 32000 32100 32200 32300 32400 32500 32600 32700 32800 32900 33000 33100 33200 33300 33400 33500 33600 33700 33800 33900 34000 34100 34200 34300 34400 34500 34600 34700 34800 34900 35000 35100 35200 35300 35400 35500 35600 35700 35800 35900 36000 36100 36200 36300 36400 36500 36600 36700 36800 36900 37000 37100 37200 37300 37400 37500 37600 37700 37800 37900 38000 38100 38200 38300 38400 38500 38600 38700 38800 38900 39000 39100 39200 39300 39400 39500 39600 39700 39800 39900 40000 40100 40200 40300 40400 40500 40600 40700 40800 40900 41000 41100 41200 41300 41400 41500 41600 41700 41800 41900 42000 42100 42200 42300 42400 42500 42600 42700 42800 42900 43000 43100 43200 43300 43400 43500 43600 43700 43800 43900 44000 44100 44200 44300 44400 44500 44600 44700 44800 44900 45000 45100 45200 45300 45400 45500 45600 45700 45800 45900 46000 46100 46200 46300 46400 46500 46600 46700 46800 46900 47000 47100 47200 47300 47400 47500 47600 47700 47800 47900 48000 48100 48200 48300 48400 48500 48600 48700 48800 48900 49000 49100 49200 49300 49400 49500 49600 49700 49800 49900 50000]
#define BLOCKLIGHT_MULTIPLIER   800.0
#define BLOCKLIGHTMAP_MULTIPLIER  1.0
#define BLOCKLIGHTMAP_EXPONENT    1.2

//////////////////////////////////////////////////////////
/*------------------ AMBIENT OCCLUSION -----------------*/
//////////////////////////////////////////////////////////
#define AO        1 // [0 1]
#define AO_TYPE   0 // [0 1]

#define SSAO_FILTER     1 // [0 1]
#define SSAO_SAMPLES   12 // [4 8 12 16 20]
#define SSAO_RADIUS   0.6
#define SSAO_STRENGTH 1.5

#define RTAO_SAMPLES    3 // [3 7]
#define RTAO_STEPS     32
#define RTAO_STRENGTH 1.3

//////////////////////////////////////////////////////////
/*---------------------- SHADOWS -----------------------*/
//////////////////////////////////////////////////////////
#define SHADOWS      1 // [0 1]
#define SOFT_SHADOWS 0 // [0 1]

#define SHADOW_SAMPLES      3 // [1 2 3 4 5 6]
#define SHADOW_BIAS      5e-4
#define SHADOW_DISTORTION 0.7

// Soft Shadows
#define PCSS_SAMPLES            16 // [16 24]
#define BLOCKER_SEARCH_SAMPLES   8 // [8 12]
#define BLOCKER_SEARCH_RADIUS 12.0
#define LIGHT_SIZE           140.0

//////////////////////////////////////////////////////////
/*-------------------- RAY TRACING ---------------------*/
//////////////////////////////////////////////////////////
#define BINARY_REFINEMENT 1 // [0 1]
#define BINARY_COUNT      6 // [4 5 6 7 8 9 10]
#define BINARY_DECREASE 0.5

#define RAY_STEP_LENGTH      1.5 // [1.0 1.5]
#define RAY_DEPTH_TOLERANCE 5e-3

//////////////////////////////////////////////////////////
/*---------------- GLOBAL ILLUMINATION -----------------*/
//////////////////////////////////////////////////////////
#define GI        0 // [0 1]
#define GI_FILTER 0

#define GI_SAMPLES            1 // [1 2 3 4 5 6 7 8]
#define GI_BOUNCES            4 // [1 2 3 4 5 6 7 8 9 10 11 12]
#define GI_STEPS             40 // [40 128 256]
#define GI_RESOLUTION      1.00 // [0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define ROULETTE_MIN_BOUNCES 3

#define GI_TEMPORAL_ACCUMULATION     1 // [0 1]
#define ACCUMULATION_VELOCITY_WEIGHT 0 // [0 1]
#define SKY_CONTRIBUTION             0 // [0 1]

//////////////////////////////////////////////////////////
/*------------- REFLECTIONS | REFRACTIONS --------------*/
//////////////////////////////////////////////////////////

#define REFLECTIONS      1 // [0 1]
#define REFLECTIONS_TYPE 1 // [0 1]
#define REFRACTIONS      0 // [0 1]

const float hardCodedRoughness = 0.0; // 0.0 = OFF
#define ATTENUATION_FACTOR 0.2

#define SKY_FALLBACK     1
#define SSR_REPROJECTION 1 // [0 1]

#define ROUGH_SAMPLES        2 // [2 8]
#define ROUGH_REFLECT_STEPS 40 // [40 64]
#define REFLECTIONS_RES   1.00 // [0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

#define SIMPLE_REFLECT_STEPS 64
#define REFRACT_STEPS        80

//////////////////////////////////////////////////////////
/*-------------------- ATMOSPHERICS --------------------*/
//////////////////////////////////////////////////////////

#define RAIN_FOG             1 // [0 1]
#define RAIN_FOG_DENSITY 400.0 // [10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0 110.0 120.0 130.0 140.0 150.0 160.0 170.0 180.0 190.0 200.0 210.0 220.0 230.0 240.0 250.0 260.0 270.0 280.0 290.0 300.0 310.0 320.0 330.0 340.0 350.0 360.0 370.0 380.0 390.0 400.0 410.0 420.0 430.0 440.0 450.0 460.0 470.0 480.0 490.0 500.0 510.0 520.0 530.0 540.0 550.0 560.0 570.0 580.0 590.0 600.0 610.0 620.0 630.0 640.0 650.0 660.0 670.0 680.0 690.0 700.0 710.0 720.0 730.0 740.0 750.0 760.0 770.0 780.0 790.0 800.0 810.0 820.0 830.0 840.0 850.0 860.0 870.0 880.0 890.0 900.0 910.0 920.0 930.0 940.0 950.0 960.0 970.0 980.0 990.0 1000.0]

#define WATER_FOG 1 // [0 1]
#define WATER_FOG_STEPS 16 // [4 8 16 32]

#define CELESTIAL_SIZE_MULTIPLIER 1 // [1 2 3 4]
#define ATMOSPHERE_RESOLUTION  0.25 // [0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define SCATTERING_STEPS         16 // [8 12 16 20 24 28 32 36]
#define TRANSMITTANCE_STEPS       8 // [8 12 16 20 24 28 32 36]

#define VL         0 // [0 1]
#define VL_FILTER  1 // [0 1]
#define VL_STEPS  16 // [4 8 16 32]

#define VL_ALTITUDE     64.0
#define VL_DENSITY      500.0 // [10.0 20.0 30.0 40.0 50.0 60.0 70.0 80.0 90.0 100.0 110.0 120.0 130.0 140.0 150.0 160.0 170.0 180.0 190.0 200.0 210.0 220.0 230.0 240.0 250.0 260.0 270.0 280.0 290.0 300.0 310.0 320.0 330.0 340.0 350.0 360.0 370.0 380.0 390.0 400.0 410.0 420.0 430.0 440.0 450.0 460.0 470.0 480.0 490.0 500.0 510.0 520.0 530.0 540.0 550.0 560.0 570.0 580.0 590.0 600.0 610.0 620.0 630.0 640.0 650.0 660.0 670.0 680.0 690.0 700.0 710.0 720.0 730.0 740.0 750.0 760.0 770.0 780.0 790.0 800.0 810.0 820.0 830.0 840.0 850.0 860.0 870.0 880.0 890.0 900.0 910.0 920.0 930.0 940.0 950.0 960.0 970.0 980.0 990.0 1000.0]
#define VL_RAIN_DENSITY (VL_DENSITY * 2.5)

#define STARS_AMOUNT      0.10 // [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define STARS_BRIGHTNESS  0.60 // [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define STARS_MIN_TEMP  2500.0
#define STARS_MAX_TEMP 50000.0

#define CLOUDS_STEPS        16
#define CLOUDS_ALTITUDE    6e3
#define CLOUDS_THICKNESS 100.0

//////////////////////////////////////////////////////////
/*------------------------ WORLD -----------------------*/
//////////////////////////////////////////////////////////

#define WHITE_WORLD    0 // [0 1]
#define ANIMATED_WATER 1 // [0 1]

#define WATER_DENSITY 1.00 // [0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00]

#define WATER_ABSORPTION_R 215 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255]
#define WATER_ABSORPTION_G 125 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255]
#define WATER_ABSORPTION_B 110 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255]

#define WATER_SCATTERING_R 25 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255]
#define WATER_SCATTERING_G 60 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255]
#define WATER_SCATTERING_B 75 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255]

#define WAVES_AMOUNT      6
#define WAVE_AMPLITUDE 0.09
#define WAVE_STEEPNESS 3.75 // [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00 2.05 2.10 2.15 2.20 2.25 2.30 2.35 2.40 2.45 2.50 2.55 2.60 2.65 2.70 2.75 2.80 2.85 2.90 2.95 3.00 3.05 3.10 3.15 3.20 3.25 3.30 3.35 3.40 3.45 3.50 3.55 3.60 3.65 3.70 3.75 3.80 3.85 3.90 3.95 4.00 4.05 4.10 4.15 4.20 4.25 4.30 4.35 4.40 4.45 4.50 4.55 4.60 4.65 4.70 4.75 4.80 4.85 4.90 4.95 5.00 5.05 5.10 5.15 5.20 5.25 5.30 5.35 5.40 5.45 5.50 5.55 5.60 5.65 5.70 5.75 5.80 5.85 5.90 5.95 6.00 6.05 6.10 6.15 6.20 6.25 6.30 6.35 6.40 6.45 6.50 6.55 6.60 6.65 6.70 6.75 6.80 6.85 6.90 6.95 7.00 7.05 7.10 7.15 7.20 7.25 7.30 7.35 7.40 7.45 7.50 7.55 7.60 7.65 7.70 7.75 7.80 7.85 7.90 7.95 8.00 8.05 8.10 8.15 8.20 8.25 8.30 8.35 8.40 8.45 8.50 8.55 8.60 8.65 8.70 8.75 8.80 8.85 8.90 8.95 9.00 9.05 9.10 9.15 9.20 9.25 9.30 9.35 9.40 9.45 9.50 9.55 9.60 9.65 9.70 9.75 9.80 9.85 9.90 9.95 10.00]
#define WAVE_LENGTH    7.00 // [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00 1.05 1.10 1.15 1.20 1.25 1.30 1.35 1.40 1.45 1.50 1.55 1.60 1.65 1.70 1.75 1.80 1.85 1.90 1.95 2.00 2.05 2.10 2.15 2.20 2.25 2.30 2.35 2.40 2.45 2.50 2.55 2.60 2.65 2.70 2.75 2.80 2.85 2.90 2.95 3.00 3.05 3.10 3.15 3.20 3.25 3.30 3.35 3.40 3.45 3.50 3.55 3.60 3.65 3.70 3.75 3.80 3.85 3.90 3.95 4.00 4.05 4.10 4.15 4.20 4.25 4.30 4.35 4.40 4.45 4.50 4.55 4.60 4.65 4.70 4.75 4.80 4.85 4.90 4.95 5.00 5.05 5.10 5.15 5.20 5.25 5.30 5.35 5.40 5.45 5.50 5.55 5.60 5.65 5.70 5.75 5.80 5.85 5.90 5.95 6.00 6.05 6.10 6.15 6.20 6.25 6.30 6.35 6.40 6.45 6.50 6.55 6.60 6.65 6.70 6.75 6.80 6.85 6.90 6.95 7.00 7.05 7.10 7.15 7.20 7.25 7.30 7.35 7.40 7.45 7.50 7.55 7.60 7.65 7.70 7.75 7.80 7.85 7.90 7.95 8.00 8.05 8.10 8.15 8.20 8.25 8.30 8.35 8.40 8.45 8.50 8.55 8.60 8.65 8.70 8.75 8.80 8.85 8.90 8.95 9.00 9.05 9.10 9.15 9.20 9.25 9.30 9.35 9.40 9.45 9.50 9.55 9.60 9.65 9.70 9.75 9.80 9.85 9.90 9.95 10.00]
#define WAVE_SPEED     0.20 // [0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

#define WATER_FOAM               1 // [0 1]
#define FOAM_FALLOFF_DISTANCE  0.1
#define FOAM_EDGE_FALLOFF     0.05
#define FOAM_FALLOFF_BIAS     0.01

#define WATER_CAUSTICS            1 // [0 1]
#define WATER_CAUSTICS_STRENGTH  10 // [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200]
#define WATER_CAUSTICS_SPEED    7.0 // [1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 21.0 22.0 23.0 24.0 25.0 26.0 27.0 28.0 29.0 30.0 31.0 32.0 33.0 34.0 35.0 36.0 37.0 38.0 39.0 40.0 41.0 42.0 43.0 44.0 45.0 46.0 47.0 48.0 49.0 50.0]
#define WATER_CAUSTICS_SIZE    70.0 // [1.0 2.0 3.0 4.0 5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 21.0 22.0 23.0 24.0 25.0 26.0 27.0 28.0 29.0 30.0 31.0 32.0 33.0 34.0 35.0 36.0 37.0 38.0 39.0 40.0 41.0 42.0 43.0 44.0 45.0 46.0 47.0 48.0 49.0 50.0 51.0 52.0 53.0 54.0 55.0 56.0 57.0 58.0 59.0 60.0 61.0 62.0 63.0 64.0 65.0 66.0 67.0 68.0 69.0 70.0 71.0 72.0 73.0 74.0 75.0 76.0 77.0 78.0 79.0 80.0 81.0 82.0 83.0 84.0 85.0 86.0 87.0 88.0 89.0 90.0 91.0 92.0 93.0 94.0 95.0 96.0 97.0 98.0 99.0 100.0]
#define WATER_CAUSTICS_MAX_SIZE 100
#define WATER_CAUSTICS_SHIFT    0.4

#define RAIN_PUDDLES             1 // [0 1]
#define RAIN_PUDDLES_SIZE     0.65 // [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95]
#define RAIN_PUDDLES_STRENGTH 0.60 // [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95]

#define RAIN_DIRECTION       vec2(0.35, 0.1)
#define RAIN_ANGLE_INTENSITY 1.0

//////////////////////////////////////////////////////////
/*----------------------- CAMERA -----------------------*/
//////////////////////////////////////////////////////////

#define TAA               1 // [0 1]
#define NEIGHBORHOOD_SIZE 1 // [1 2 3]

#define TAA_STRENGTH     0.950 // [0.800 0.825 0.850 0.875 0.900 0.925 0.950 0.975]
#define TAA_LUMA_MIN     0.15
#define TAA_FEEDBACK_MIN (TAA_STRENGTH)
#define TAA_FEEDBACK_MAX (TAA_STRENGTH + 0.01)

#define DOF           0 // [0 1]
#define DOF_RADIUS 20.0 // [5.0 6.0 7.0 8.0 9.0 10.0 11.0 12.0 13.0 14.0 15.0 16.0 17.0 18.0 19.0 20.0 21.0 22.0 23.0 24.0 25.0 26.0 27.0 28.0 29.0 30.0 31.0 32.0 33.0 34.0 35.0 36.0 37.0 38.0 39.0 40.0]

#define BLOOM             1 // [0 1]
#define BLOOM_STRENGTH 0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define BLOOM_TWEAK_VAL 0.0

#define BLOOM_STEPS   5
#define BLOOM_SIGMA 2.0

#define VIGNETTE             0 // [0 1]
#define VIGNETTE_STRENGTH 0.25 // [0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50]

#define FILM_GRAIN             0 // [0 1]
#define FILM_GRAIN_STRENGTH 2.50 // [0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 1.60 1.70 1.80 1.90 2.00 2.10 2.20 2.30 2.40 2.50 2.60 2.70 2.80 2.90 3.00 3.10 3.20 3.30 3.40 3.50 3.60 3.70 3.80 3.90 4.00 4.10 4.20 4.30 4.40 4.50 4.60 4.70 4.80 4.90 5.00]

#define CHROMATIC_ABERRATION   0 // [0 1]
#define ABERRATION_STRENGTH 2.00 // [0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00 2.25 2.50 2.75 3.00 3.25 3.50 3.75 4.00]

#define SHARPEN             1 // [0 1]
#define SHARPEN_STRENGTH 1.00 // [0.25 0.50 0.75 1.00 1.25 1.50 1.75 2.00 2.25 2.50 2.75 3.0]

#define UNDERWATER_DISTORTION         1
#define WATER_DISTORTION_SPEED     0.65
#define WATER_DISTORTION_AMPLITUDE 0.40

#define EXPOSURE 1 // [0 1]
#define PURKINJE 1 // [0 1]

const float K =  12.5; // Light meter calibration
const float S = 100.0; // Sensor sensitivity

#define FOCAL          20 // [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30]
#define APERTURE      8.0 // [1.0 1.2 1.4 2.0 2.8 4.0 5.6 8.0 11.0 16.0 22.0 32.0]
#define ISO           100 // [50 100 200 400 800 1600 3200 6400 12800 25600 51200]
#define SHUTTER_SPEED  80 // [4 5 6 8 10 15 20 30 40 50 60 80 100 125 160 200 250 320 400 500 640 800 1000 1250 1600 2000 2500 3200 4000]

//////////////////////////////////////////////////////////
/*------------------ COLOR CORRECTION ------------------*/
//////////////////////////////////////////////////////////

#define TONEMAP 4 // [-1 0 1 2 3 4 5 6]
#define LUT     0 // [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19]

#define WHITE_BALANCE 6000 // [5000 5100 5200 5300 5400 5500 5600 5700 5800 5900 6000 6100 6200 6300 6400 6500 6600 6700 6800 6900 7000 7100 7200 7300 7400 7500 7600 7700 7800 7900 8000 8100 8200 8300 8400 8500 8600 8700 8800 8900 9000 9100 9200 9300 9400 9500 9600 9700 9800 9900 10000 10100 10200 10300 10400 10500 10600 10700 10800 10900 11000 11100 11200 11300 11400 11500 11600 11700 11800 11900 12000 12100 12200 12300 12400 12500 12600 12700 12800 12900 13000 13100 13200 13300 13400 13500 13600 13700 13800 13900 14000 14100 14200 14300 14400 14500 14600 14700 14800 14900 15000]
#define VIBRANCE      0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define SATURATION    0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define CONTRAST      0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define GAMMA         0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define GAIN          0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]
#define LIFT          0.00 // [-1.00 -0.95 -0.90 -0.85 -0.80 -0.75 -0.70 -0.65 -0.60 -0.55 -0.50 -0.45 -0.40 -0.35 -0.30 -0.25 -0.20 -0.15 -0.10 -0.05 0.00 0.05 0.10 0.15 0.20 0.25 0.30 0.35 0.40 0.45 0.50 0.55 0.60 0.65 0.70 0.75 0.80 0.85 0.90 0.95 1.00]

/*------------------ VANILLA AO ------------------*/
#if AO == 1 || GI == 1
     const float ambientOcclusionLevel = 0.0;
#else
     const float ambientOcclusionLevel = 1.0;
#endif
