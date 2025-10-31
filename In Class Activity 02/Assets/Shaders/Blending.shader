Shader "Custom/Blending"
{
   Properties
    {
        _MainTex ("Texture", 2D) = "white" {}  
        _BaseColor ("Base Color", Color) = (1, 1, 1, 1)  
    }
    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" "Queue" = "Transparent" "RenderType" = "Transparent" }

        Blend OneMinusDstColor One
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
         
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            struct Attributes
            {
                float4 positionOS : POSITION; 
                float2 uv : TEXCOORD0;        
            };
            struct Varyings
            {
                float4 positionHCS : SV_POSITION; 
                float2 uv : TEXCOORD0;            
            };
           
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            float4 _BaseColor;
            
            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;  
                return OUT;
            }
            
            half4 frag(Varyings IN) : SV_Target
            {
                
                half4 texColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv);
                
                half4 finalColor = texColor * _BaseColor;
                return finalColor;
            }
            ENDHLSL
        }
    }
}
