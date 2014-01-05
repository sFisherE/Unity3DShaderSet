Shader "ShaderSet/Greyscale"
{
	Properties{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "white" {}
	}
	
	SubShader
	{
		Pass
		{
		CGPROGRAM
		#pragma vertex vert_img
		#pragma fragment frag
		#include "UnityCG.cginc"

		uniform sampler2D _MainTex;
		fixed4 frag (v2f_img i) : COLOR
		{
			fixed4 output=tex2D(_MainTex, i.uv);
			fixed greyscale = Luminance(output.rgb);
			output.r=greyscale;
			output.g=greyscale;
			output.b=greyscale;
			return output;
		}
		ENDCG
		}
	}
}