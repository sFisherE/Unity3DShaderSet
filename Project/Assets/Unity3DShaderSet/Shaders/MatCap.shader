Shader "ShaderSet/MatCap"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_MatCap ("MatCap (RGB)", 2D) = "white" {}
	}
	
	Subshader
	{
		Tags { "RenderType"="Opaque" }
		
		Pass
		{
			Tags { "LightMode" = "Always" }
			
			CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma fragmentoption ARB_precision_hint_fastest
				#include "UnityCG.cginc"
				#include "ShaderSet.cginc"
				
				struct v2f
				{
					float4 pos	: SV_POSITION;
					float2 uv 	: TEXCOORD0;
					float2 cap	: TEXCOORD1;
				};
				uniform float4 _MainTex_ST;
				v2f vert (appdata_base v)
				{
					v2f o;
					o.pos = GetHomogenousCoordinates(v.vertex);
					o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);

					o.cap =GetMatCapCoordinates(v.normal);
					return o;
				}
				
				uniform sampler2D _MainTex;
				uniform sampler2D _MatCap;
				fixed4 frag (v2f i) : COLOR
				{
					fixed4 tex = tex2D(_MainTex, i.uv);
					fixed4 mc = tex2D(_MatCap, i.cap);
					return tex * mc * 2.0;
				}
			ENDCG
		}
	}
	
	Fallback "VertexLit"
}