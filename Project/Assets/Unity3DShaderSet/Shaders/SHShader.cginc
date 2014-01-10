//spherical harmonics lighting

//collect some common sh lighting effect
//I should find the way to generate coefficients
//this solution will be cheaper than Unity3D'buildin light probe solution

#ifndef SHSHADER_INCLUDED
#define SHSHADER_INCLUDED
#endif
#define SH_COLOR(normal) C1 * L22 * (normal.x * normal.x - normal.y * normal.y) + \
                    C3 * L20 * normal.z * normal.z + \
                    C4 * L00 - \
                    C5 * L20 + \
                    2.0 * C1 * L2m2 * normal.x * normal.y + \
                    2.0 * C1 * L21  * normal.x * normal.z + \
                    2.0 * C1 * L2m1 * normal.y * normal.z + \
                    2.0 * C2 * L11  * normal.x + \
                    2.0 * C2 * L1m1 * normal.y + \
                    2.0 * C2 * L10  * normal.z;
#define SH_COMMON_CONST const float C1 = 0.429043; \
		const float C2 = 0.511664; \
		const float C3 = 0.743125; \
		const float C4 = 0.886227; \
		const float C5 = 0.247708;

inline float3 GetOldTownSquareSHColor(float3 eyeSpaceNormal)
{
		SH_COMMON_CONST
		const	float3 L00  = float3( 0.871297,  0.875222,  0.864470);
		const	float3 L1m1 = float3( 0.175058,  0.245335,  0.312891);
		const	float3 L10  = float3( 0.034675,  0.036107,  0.037362);
		const	float3 L11  = float3(-0.004629, -0.029448, -0.048028);
		const	float3 L2m2 = float3(-0.120535, -0.121160, -0.117507);
		const	float3 L2m1 = float3( 0.003242,  0.003624,  0.007511);
		const	float3 L20  = float3(-0.028667, -0.024926, -0.020998);
		const	float3 L21  = float3(-0.077539, -0.086325, -0.091591);
		const	float3 L22  = float3(-0.161784, -0.191783, -0.219152);
		return SH_COLOR(eyeSpaceNormal)
}
inline float3 GetGraceCathedralSHColor(float3 eyeSpaceNormal)
{
		SH_COMMON_CONST
		const	float3 L00  = float3( 0.79,  0.44,  0.54);
		const	float3 L1m1 = float3( 0.39,  0.35,  0.60);
		const	float3 L10  = float3( -0.34,  -0.18,  -0.27);
		const	float3 L11  = float3(-0.29, -0.06, 0.01);
		const	float3 L2m2 = float3(-0.11, -0.05, -0.12);
		const	float3 L2m1 = float3( -0.26,  -0.22,  -0.47);
		const	float3 L20  = float3(-0.16, -0.09, -0.15);
		const	float3 L21  = float3(0.56, 0.21, 0.14);
		const	float3 L22  = float3(0.21, -0.05, -0.30);
		return SH_COLOR(eyeSpaceNormal)
}
inline float3 GetEucalyptusGroveSHColor(float3 eyeSpaceNormal)
{
		SH_COMMON_CONST
		const float3 L00  = float3( 0.38,  0.43,  0.45);
		const float3 L1m1 = float3( 0.29,  0.36,  0.41);
		const float3 L10  = float3( 0.04,0.03,0.01);
		const float3 L11  = float3(-0.10,-0.10,-0.09);
		const float3 L2m2 = float3(-0.06,-0.06,-0.04);
		const float3 L2m1 = float3(0.01,-0.01,-0.05);
		const float3 L20  = float3(-0.09,-0.13,-0.15);
		const float3 L21  = float3(-0.06,-0.05,-0.04);
		const float3 L22  = float3(0.02,0.00,-0.05);
		return SH_COLOR(eyeSpaceNormal)
}
inline float3  GetStPetersBasilica(float3 eyeSpaceNormal)
{
		SH_COMMON_CONST
		const	float3 L00  = float3(0.36,0.26,0.23);
		const	float3 L1m1 = float3( 0.18,0.14,0.13);
		const	float3 L10  = float3( 0.02,0.01,0.00);
		const	float3 L11  = float3(0.03,0.02,0.00);
		const	float3 L2m2 = float3(0.02,0.01,0.00);
		const	float3 L2m1 = float3(-0.05,-0.03,-0.01);
		const	float3 L20  = float3(-0.09,-0.08,-0.07);
		const	float3 L21  = float3(0.01,0.00,0.00);
		const	float3 L22  = float3(-0.08,-0.03,0.00);
		return SH_COLOR(eyeSpaceNormal)
}

