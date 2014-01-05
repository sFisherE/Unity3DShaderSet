//http://www.yaldex.com/open-gl/ch12lev1sec3.html
Shader "ShaderSet/SH Lighting" {
Properties {
    _MainTex ("Texture", 2D) = "white" {}
}
SubShader {
    Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"
		#include "ShaderSet.cginc"
//		float4 _SkyColor;
//		float4 _GroundColor;
		sampler2D _MainTex;
		struct v2f {
			float4  pos : SV_POSITION;
			float2  uv : TEXCOORD0;
			fixed4 color : COLOR0;
		};
		float4 _MainTex_ST;
		v2f vert (appdata_base v)
		{
			float C1 = 0.429043;
			float C2 = 0.511664;
			float C3 = 0.743125;
			float C4 = 0.886227;
			float C5 = 0.247708;
			// Constants for Old Town Square lighting
			float3 L00  = float3( 0.871297,  0.875222,  0.864470);
			float3 L1m1 = float3( 0.175058,  0.245335,  0.312891);
			float3 L10  = float3( 0.034675,  0.036107,  0.037362);
			float3 L11  = float3(-0.004629, -0.029448, -0.048028);
			float3 L2m2 = float3(-0.120535, -0.121160, -0.117507);
			float3 L2m1 = float3( 0.003242,  0.003624,  0.007511);
			float3 L20  = float3(-0.028667, -0.024926, -0.020998);
			float3 L21  = float3(-0.077539, -0.086325, -0.091591);
			float3 L22  = float3(-0.161784, -0.191783, -0.219152);
			
//			float3 L00  = float3( 0.38,  0.43,  0.45);
//			float3 L1m1 = float3( 0.29,  0.36,  0.41);
//			float3 L10  = float3( 0.04,0.03,0.01);
//			float3 L11  = float3(-0.10,-0.10,-0.09);
//			float3 L2m2 = float3(-0.06,-0.06,-0.04);
//			float3 L2m1 = float3(0.01,-0.01,-0.05);
//			float3 L20  = float3(-0.09,-0.13,-0.15);
//			float3 L21  = float3(-0.06,-0.05,-0.04);
//			float3 L22  = float3(0.02,0.00,-0.05);
			

			v2f o;
			o.pos =GetProjectionSpacePosition(v.vertex);
			o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
			
//			float costheta = dot(GetEyeSpaceNormal(v.normal), fixed3(0,1,0));
			float3 tnorm = GetEyeSpaceNormal(v.normal);
//			o.color=_SkyColor*a+(1-a)*_GroundColor;

			o.color.rgb=C1 * L22 * (tnorm.x * tnorm.x - tnorm.y * tnorm.y) +
                    C3 * L20 * tnorm.z * tnorm.z +
                    C4 * L00 -
                    C5 * L20 +
                    2.0 * C1 * L2m2 * tnorm.x * tnorm.y +
                    2.0 * C1 * L21  * tnorm.x * tnorm.z +
                    2.0 * C1 * L2m1 * tnorm.y * tnorm.z +
                    2.0 * C2 * L11  * tnorm.x +
                    2.0 * C2 * L1m1 * tnorm.y +   
                    2.0 * C2 * L10  * tnorm.z;
			return o;
		}
		half4 frag (v2f i) : COLOR
		{
			half4 texcol = tex2D (_MainTex, i.uv);
			texcol.r*=i.color.r;
			texcol.g*=i.color.g;
			texcol.b*=i.color.b;
			return texcol;
		}
		ENDCG
    }
}
	FallBack "Diffuse"
}
