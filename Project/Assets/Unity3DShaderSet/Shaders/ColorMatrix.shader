Shader "ShaderSet/ColorMatrix"
{
	Properties{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
		_R ("R", Vector) = (1,0,0,0)
		_G ("G", Vector) = (0,1,0,0)
		_B ("B", Vector) = (0,0,1,0)
		_A ("A", Vector) = (0,0,0,1)
		_Offset ("Offset", Vector) = (0,0,0,0)
	}
	
	SubShader
	{
		LOD 100
		//Tags
		//{
			//"Queue" = "Transparent"
			//"IgnoreProjector" = "True"
			//"RenderType" = "Transparent"
		//}
		Pass
		{
			Cull Off
			Lighting Off
			//ZWrite Off
			Fog { Mode Off }
			Offset -1, -1
			ColorMask RGB
			AlphaTest Greater .01
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMaterial AmbientAndDiffuse
			
			
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float4 _R;
			uniform float4 _G;
			uniform float4 _B;
			uniform float4 _A;
			uniform float4 _Offset;

			fixed4 frag (v2f_img i) : COLOR
			{
				fixed4 original = tex2D(_MainTex, i.uv);
				
				fixed4 output=original;
				
				output.r=_R.r*output.r+_R.g*output.g+_R.b*output.b+_R.a*output.a+_Offset.r;
				output.g=_G.r*output.r+_G.g*output.g+_G.b*output.b+_G.a*output.a+_Offset.g;
				output.b=_B.r*output.r+_B.g*output.g+_B.b*output.b+_B.a*output.a+_Offset.b;
				output.a=_A.r*output.r+_A.g*output.g+_A.b*output.b+_A.a*output.a+_Offset.a;

				return output;
			}
			ENDCG
		}
	}
}