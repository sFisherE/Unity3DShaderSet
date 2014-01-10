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
		#include "SHShader.cginc"
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
			v2f o;
			o.pos =GetHomogenousCoordinates(v.vertex);
			o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
			
			float3 tnorm = GetEyeSpaceNormal(v.normal);
			o.color.rgb=GetOldTownSquareSHColor(tnorm);
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
