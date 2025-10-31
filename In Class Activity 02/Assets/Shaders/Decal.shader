Shader "Custom/Decal"
{
   Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {} 
        _DecalTex ("Decal Texture", 2D) = "white" {}  
        [Toggle] _ShowDecal ("Show Decal?", Float) = 0  
    }

    SubShader
    {
        Tags { "RenderPipeline" = "UniversalRenderPipeline" "RenderType" = "Opaque" }

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

           
            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);
            TEXTURE2D(_DecalTex);
            SAMPLER(sampler_DecalTex);
            float _ShowDecal;  

            
            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz); 
                OUT.uv = IN.uv;  
                return OUT;
            }

            
            half4 frag(Varyings IN) : SV_Target
            {
                
                half4 mainTexColor = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv);

                
                half4 decalTexColor = SAMPLE_TEXTURE2D(_DecalTex, sampler_DecalTex, IN.uv);

                
                half4 finalColor = (_ShowDecal == 1) ? mainTexColor + decalTexColor : mainTexColor;

                return finalColor;
            }

            ENDHLSL
        }
    }
}
