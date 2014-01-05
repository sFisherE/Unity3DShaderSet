Shader "ShaderSet/Hemisphere Lighting" {
Properties {
    _MainTex ("Texture", 2D) = "white" {}
	_SkyColor("Sky Color",Color)=(1,1,1,1)
	_GroundColor("Ground Color",Color)=(0,0,0,1)
}
SubShader {
    Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#include "UnityCG.cginc"
		#include "ShaderSet.cginc"
		float4 _SkyColor;
		float4 _GroundColor;
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
			o.pos =GetProjectionSpacePosition(v.vertex);
			o.uv = TRANSFORM_TEX (v.texcoord, _MainTex);
			
			float costheta = dot(GetEyeSpaceNormal(v.normal), fixed3(0,1,0));
			float a = 0.5 + 0.5 * costheta;
			o.color=_SkyColor*a+(1-a)*_GroundColor;
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
Fallback "VertexLit"
}
