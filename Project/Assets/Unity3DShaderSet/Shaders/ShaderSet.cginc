#ifndef SHADERSET_INCLUDED
#define SHADERSET_INCLUDED
#endif
//#include "UnityShaderVariables.cginc"

//float3	normal	NORMAL
inline float3 GetEyeSpaceNormal(float3 localNormal)
{
	return mul((float3x3)UNITY_MATRIX_IT_MV, localNormal);
}

//float4	vertex	POSITION
inline float4 GetProjectionSpacePosition(float4 localPosition)
{
	return mul (UNITY_MATRIX_MVP, localPosition);
}

inline float2 GetMatCapCoord (float3 localNormal)
{
	float3 normal=mul((float3x3)UNITY_MATRIX_IT_MV, localNormal);
	return normal.xy*0.5+0.5;
}

//
inline float GetRimFactor(float4 localPosition,float3 localNormal)
{
	float3 viewDir = ObjSpaceViewDir(localPosition);
	float NdotV = max(0,dot(localNormal, viewDir));
	return 1-NdotV;
}
