Shader "GameDraw/HighlightClip" {
    // a single color property
    Properties {
        _Color ("Main Color", Color) = (1,1,1,1)
        _Emission ("Emmisive Color", Color) = (1,1,1,1)
        _Ambient ("Ambient Color", Color) = (1,1,1,1)
    }
    // define one subshader
    SubShader {
	
	  Tags { "Queue" ="Background" }
	  
	  	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 12
//   opengl - ALU: 5 to 62
//   d3d9 - ALU: 5 to 62
//   d3d11 - ALU: 1 to 28, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 1 to 28, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Matrix 5 [_Object2World]
Vector 16 [unity_Scale]
"!!ARBvp1.0
# 26 ALU
PARAM c[17] = { { 1 },
		state.matrix.mvp,
		program.local[5..16] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[16].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.y, R0, c[10];
DP4 R2.x, R0, c[9];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[14];
DP4 R3.y, R1, c[13];
DP4 R3.x, R1, c[12];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[15];
ADD R2.xyz, R2, R3;
ADD result.texcoord[1].xyz, R2, R1;
MOV result.texcoord[0].z, R2.w;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_SHAr]
Vector 9 [unity_SHAg]
Vector 10 [unity_SHAb]
Vector 11 [unity_SHBr]
Vector 12 [unity_SHBg]
Vector 13 [unity_SHBb]
Vector 14 [unity_SHC]
Matrix 4 [_Object2World]
Vector 15 [unity_Scale]
"vs_2_0
; 26 ALU
def c16, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c15.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c16.x
dp4 r2.z, r0, c10
dp4 r2.y, r0, c9
dp4 r2.x, r0, c8
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c13
dp4 r3.y, r1, c12
dp4 r3.x, r1, c11
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c14
add r2.xyz, r2, r3
add oT1.xyz, r2, r1
mov oT0.z, r2.w
mov oT0.y, r3.w
mov oT0.x, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 22 instructions, 4 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjgadejlkcodhkbjbgmghnembkejhnmkdabaaaaaajeaeaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcciadaaaaeaaaabaamkaaaaaafjaaaaaeegiocaaaaaaaaaaa
bjaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacaeaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaaaaaaaaa
bcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaaaaaaaaa
bdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaaaaaaaaa
beaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaaaaaaaaabfaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaaaaaaaaabgaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaaaaaaaaabiaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_6.w = 0.0;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_6.w = 0.0;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_SHAr]
Vector 9 [unity_SHAg]
Vector 10 [unity_SHAb]
Vector 11 [unity_SHBr]
Vector 12 [unity_SHBg]
Vector 13 [unity_SHBb]
Vector 14 [unity_SHC]
Matrix 4 [_Object2World]
Vector 15 [unity_Scale]
"agal_vs
c16 1.0 0.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaapaaaappabaaaaaa mul r1.xyz, a1, c15.w
bcaaaaaaadaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r1.xyzz, c5
bcaaaaaaacaaaiacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c6
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
aaaaaaaaaaaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.w
aaaaaaaaaaaaaeacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r2.w
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
aaaaaaaaaaaaaiacbaaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c16.x
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.z, r0, c10
bdaaaaaaacaaacacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r2.y, r0, c9
bdaaaaaaacaaabacaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 r2.x, r0, c8
adaaaaaaaaaaacacadaaaappacaaaaaaadaaaappacaaaaaa mul r0.y, r3.w, r3.w
bdaaaaaaadaaaeacabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r3.z, r1, c13
bdaaaaaaadaaacacabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 r3.y, r1, c12
bdaaaaaaadaaabacabaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 r3.x, r1, c11
adaaaaaaaeaaacacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r4.y, r0.x, r0.x
acaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaffacaaaaaa sub r0.y, r4.y, r0.y
adaaaaaaabaaahacaaaaaaffacaaaaaaaoaaaaoeabaaaaaa mul r1.xyz, r0.y, c14
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaabaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v1.xyz, r2.xyzz, r1.xyzz
aaaaaaaaaaaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.z, r2.w
aaaaaaaaaaaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.y, r3.w
aaaaaaaaaaaaabaeaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.x, r0.x
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 22 instructions, 4 temp regs, 0 temp arrays:
// ALU 12 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedninpapijfgiaopmagipamjolkfkdeddnabaaaaaaleagaaaaaeaaaaaa
daaaaaaaemacaaaahmafaaaaeeagaaaaebgpgodjbeacaaaabeacaaaaaaacpopp
lmabaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaabcaa
ahaaabaaaaaaaaaaabaaaaaaaeaaaiaaaaaaaaaaabaaamaaadaaamaaaaaaaaaa
abaabeaaabaaapaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaafbaaaapkaaaaaiadp
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaahiaacaaoejaapaappkaafaaaaadabaaahiaaaaaffia
anaaoekaaeaaaaaeaaaaaliaamaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahia
aoaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiiabaaaaakaajaaaaadabaaabia
abaaoekaaaaaoeiaajaaaaadabaaaciaacaaoekaaaaaoeiaajaaaaadabaaaeia
adaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjiaaaaakeiaajaaaaadadaaabia
aeaaoekaacaaoeiaajaaaaadadaaaciaafaaoekaacaaoeiaajaaaaadadaaaeia
agaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiia
aaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaiaaaaaaaiaaaaappibabaaaaac
aaaaahoaaaaaoeiaaeaaaaaeabaaahoaahaaoekaaaaappiaabaaoeiaafaaaaad
aaaaapiaaaaaffjaajaaoekaaeaaaaaeaaaaapiaaiaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaakaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcciadaaaaeaaaabaamkaaaaaafjaaaaae
egiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaac
aeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaai
hcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
lcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaa
aaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaaaaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaaaaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaaaaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
aaaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
aaaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
aaaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
aaaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 406
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 411
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 413
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 415
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 419
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 423
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    #line 427
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
"!!ARBvp1.0
# 5 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
MAD result.texcoord[0].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord1 v2
mad oT0.xy, v2, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 112 // 112 used size, 7 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 1 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcohokmjkjhdmffelmafcagkbgfcpilheabaaaaaaiaacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefccmabaaaaeaaaabaaelaaaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  c_1.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  c_1.xyz = (tmpvar_2 * ((8.0 * tmpvar_6.w) * tmpvar_6.xyz));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"agal_vs
[bc]
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v0.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 112 // 112 used size, 7 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 1 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedfgkllgdmmokoagfcoehcebobomcoogmmabaaaaaagmadaaaaaeaaaaaa
daaaaaaabiabaaaaemacaaaabeadaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpopp
kaaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaaeaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefccmabaaaa
eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 401
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 405
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 409
    return o;
}

out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 401
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 412
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 414
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 418
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 422
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    #line 426
    c.xyz += (o.Albedo * lm);
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD0);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
"!!ARBvp1.0
# 5 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
MAD result.texcoord[0].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"vs_2_0
; 5 ALU
dcl_position0 v0
dcl_texcoord1 v2
mad oT0.xy, v2, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 112 // 112 used size, 7 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 1 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcohokmjkjhdmffelmafcagkbgfcpilheabaaaaaaiaacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefccmabaaaaeaaaabaaelaaaaaafjaaaaae
egiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  mediump vec3 lm_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz);
  lm_6 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * lm_6);
  c_1.xyz = tmpvar_8;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  mediump vec3 lm_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((8.0 * tmpvar_6.w) * tmpvar_6.xyz);
  lm_7 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_2 * lm_7);
  c_1.xyz = tmpvar_9;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
"agal_vs
[bc]
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v0.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 112 // 112 used size, 7 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerDraw" 1
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 1 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedfgkllgdmmokoagfcoehcebobomcoogmmabaaaaaagmadaaaaaeaaaaaa
daaaaaaabiabaaaaemacaaaabeadaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpopp
kaaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaagaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoaaeaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefccmabaaaa
eaaaabaaelaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaac
abaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaa
aaaaaaaaagaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 401
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 413
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 405
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    #line 409
    return o;
}

out highp vec2 xlv_TEXCOORD0;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 401
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 413
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 316
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 320
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 325
    return lm;
}
#line 344
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 346
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 413
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 417
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 421
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = 1.0;
    lowp vec4 c = vec4( 0.0);
    #line 425
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, false).xyz;
    c.xyz += (o.Albedo * lm);
    #line 429
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD0);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 5 [_Object2World]
Vector 17 [unity_Scale]
"!!ARBvp1.0
# 31 ALU
PARAM c[18] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xyz, vertex.normal, c[17].w;
DP3 R3.w, R0, c[6];
DP3 R2.w, R0, c[7];
DP3 R1.w, R0, c[5];
MOV R1.x, R3.w;
MOV R1.y, R2.w;
MOV R1.z, c[0].x;
MUL R0, R1.wxyy, R1.xyyw;
DP4 R2.z, R1.wxyz, c[12];
DP4 R2.y, R1.wxyz, c[11];
DP4 R2.x, R1.wxyz, c[10];
DP4 R1.z, R0, c[15];
DP4 R1.y, R0, c[14];
DP4 R1.x, R0, c[13];
MUL R3.x, R3.w, R3.w;
MAD R0.x, R1.w, R1.w, -R3;
ADD R3.xyz, R2, R1;
MUL R2.xyz, R0.x, c[16];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[1].xyz, R3, R2;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.texcoord[0].z, R2.w;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R1.w;
END
# 31 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 4 [_Object2World]
Vector 17 [unity_Scale]
"vs_2_0
; 31 ALU
def c18, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c17.w
dp3 r3.w, r0, c5
dp3 r2.w, r0, c6
dp3 r1.w, r0, c4
mov r1.x, r3.w
mov r1.y, r2.w
mov r1.z, c18.x
mul r0, r1.wxyy, r1.xyyw
dp4 r2.z, r1.wxyz, c12
dp4 r2.y, r1.wxyz, c11
dp4 r2.x, r1.wxyz, c10
dp4 r1.z, r0, c15
dp4 r1.y, r0, c14
dp4 r1.x, r0, c13
mul r3.x, r3.w, r3.w
mad r0.x, r1.w, r1.w, -r3
add r3.xyz, r2, r1
mul r2.xyz, r0.x, c16
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c18.y
mul r1.y, r1, c8.x
add oT1.xyz, r3, r2
mad oT2.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mov oT0.z, r2.w
mov oT0.y, r3.w
mov oT0.x, r1.w
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 27 instructions, 5 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedopjdimpbcbnfmlejbhmlidhbjohodpikabaaaaaafeafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
naadaaaaeaaaabaapeaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaabaaaaaabcaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaabaaaaaabdaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaabaaaaaabeaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
abaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
abaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
abaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaabiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * tmpvar_6) * 2.0));
  c_12.w = 0.0;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_23;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x) * 2.0));
  c_6.w = 0.0;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Matrix 4 [_Object2World]
Vector 16 [unity_Scale]
Vector 17 [unity_NPOTScale]
"agal_vs
c18 1.0 0.5 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaabaaaaappabaaaaaa mul r0.xyz, a1, c16.w
bcaaaaaaadaaaiacaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r0.xyzz, c5
bcaaaaaaacaaaiacaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r0.xyzz, c6
bcaaaaaaabaaaiacaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r1.w, r0.xyzz, c4
aaaaaaaaabaaabacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r3.w
aaaaaaaaabaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.w
aaaaaaaaabaaaeacbcaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r1.z, c18.x
adaaaaaaaaaaapacabaaaafdacaaaaaaabaaaaneacaaaaaa mul r0, r1.wxyy, r1.xyyw
bdaaaaaaacaaaeacabaaaajdacaaaaaaalaaaaoeabaaaaaa dp4 r2.z, r1.wxyz, c11
bdaaaaaaacaaacacabaaaajdacaaaaaaakaaaaoeabaaaaaa dp4 r2.y, r1.wxyz, c10
bdaaaaaaacaaabacabaaaajdacaaaaaaajaaaaoeabaaaaaa dp4 r2.x, r1.wxyz, c9
bdaaaaaaabaaaeacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r1.z, r0, c14
bdaaaaaaabaaacacaaaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r1.y, r0, c13
bdaaaaaaabaaabacaaaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 r1.x, r0, c12
adaaaaaaadaaabacadaaaappacaaaaaaadaaaappacaaaaaa mul r3.x, r3.w, r3.w
adaaaaaaaeaaabacabaaaappacaaaaaaabaaaappacaaaaaa mul r4.x, r1.w, r1.w
acaaaaaaaaaaabacaeaaaaaaacaaaaaaadaaaaaaacaaaaaa sub r0.x, r4.x, r3.x
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r2.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaaaaacaaaaaaapaaaaoeabaaaaaa mul r1.xyz, r0.x, c15
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaadaaahacaaaaaapeacaaaaaabcaaaaffabaaaaaa mul r3.xyz, r0.xyww, c18.y
abaaaaaaabaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v1.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaacacadaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r3.y, c8.x
aaaaaaaaabaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r3.x
abaaaaaaabaaadacabaaaafeacaaaaaaadaaaakkacaaaaaa add r1.xy, r1.xyyy, r3.z
adaaaaaaacaaadaeabaaaafeacaaaaaabbaaaaoeabaaaaaa mul v2.xy, r1.xyyy, c17
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaacaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r0.wwzw
aaaaaaaaaaaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.z, r2.w
aaaaaaaaaaaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.y, r3.w
aaaaaaaaaaaaabaeabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.x, r1.w
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 27 instructions, 5 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedifooagejneeloaeodpjdpgknolmnicnjabaaaaaammahaaaaaeaaaaaa
daaaaaaakeacaaaahmagaaaaeeahaaaaebgpgodjgmacaaaagmacaaaaaaacpopp
aiacaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
abaaabaaaaaaaaaaabaabcaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaadaaanaaaaaaaaaaacaabeaaabaabaaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbbaaapkaaaaaiadpaaaaaadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaacaaoejabaaappka
afaaaaadabaaahiaaaaaffiaaoaaoekaaeaaaaaeaaaaaliaanaakekaaaaaaaia
abaakeiaaeaaaaaeaaaaahiaapaaoekaaaaakkiaaaaapeiaabaaaaacaaaaaiia
bbaaaakaajaaaaadabaaabiaacaaoekaaaaaoeiaajaaaaadabaaaciaadaaoeka
aaaaoeiaajaaaaadabaaaeiaaeaaoekaaaaaoeiaafaaaaadacaaapiaaaaacjia
aaaakeiaajaaaaadadaaabiaafaaoekaacaaoeiaajaaaaadadaaaciaagaaoeka
acaaoeiaajaaaaadadaaaeiaahaaoekaacaaoeiaacaaaaadabaaahiaabaaoeia
adaaoeiaafaaaaadaaaaaiiaaaaaffiaaaaaffiaaeaaaaaeaaaaaiiaaaaaaaia
aaaaaaiaaaaappibabaaaaacaaaaahoaaaaaoeiaaeaaaaaeabaaahoaaiaaoeka
aaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffjaakaaoekaaeaaaaaeaaaaapia
ajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaafaaaaadabaaabiaaaaaffia
abaaaakaafaaaaadabaaaiiaabaaaaiabbaaffkaafaaaaadabaaafiaaaaapeia
bbaaffkaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoaaaaaoeia
ppppaaaafdeieefcnaadaaaaeaaaabaapeaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacafaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
abaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaabaaaaaa
egacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaai
bcaabaaaacaaaaaaegiocaaaabaaaaaabcaaaaaaegaobaaaabaaaaaabbaaaaai
ccaabaaaacaaaaaaegiocaaaabaaaaaabdaaaaaaegaobaaaabaaaaaabbaaaaai
ecaabaaaacaaaaaaegiocaaaabaaaaaabeaaaaaaegaobaaaabaaaaaadiaaaaah
pcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaa
aeaaaaaaegiocaaaabaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaa
aeaaaaaaegiocaaaabaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaa
aeaaaaaaegiocaaaabaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahccaabaaaabaaaaaa
bkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakbcaabaaaabaaaaaaakaabaaa
abaaaaaaakaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaadcaaaaakhccabaaa
acaaaaaaegiccaaaabaaaaaabiaaaaaaagaabaaaabaaaaaaegacbaaaacaaaaaa
diaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaa
diaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaa
aaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaah
dccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 423
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 415
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 419
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 423
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 423
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 427
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 431
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 435
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 439
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
"!!ARBvp1.0
# 10 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
"vs_2_0
; 10 ALU
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
mad oT1.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT1.zw, r0
mad oT0.xy, v2, c10, c10.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 8 vars
Vector 160 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcbbblengjeljhcopbdcfjhnhmjjdembcabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w))), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz), vec3((tmpvar_6 * 2.0))));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = o_2;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((8.0 * tmpvar_7.w) * tmpvar_7.xyz);
  c_1.xyz = (tmpvar_2 * max (min (tmpvar_8, ((tmpvar_6.x * 2.0) * tmpvar_7.xyz)), (tmpvar_8 * tmpvar_6.x)));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
Vector 10 [unity_LightmapST]
"agal_vs
c11 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaaalaaaaaaabaaaaaa mul r1.xyz, r0.xyww, c11.x
adaaaaaaabaaacacabaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r1.y, c8.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
adaaaaaaabaaadaeabaaaafeacaaaaaaajaaaaoeabaaaaaa mul v1.xy, r1.xyyy, c9
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaabaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, r0.wwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a4, c10
abaaaaaaaaaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v0.xy, r0.xyyy, c10.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 8 vars
Vector 160 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedahbnkfohpkepegckbbidjciajmncepcpabaaaaaajmaeaaaaaeaaaaaa
daaaaaaaiiabaaaageadaaaacmaeaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
aeabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaakaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoa
aeaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiaahaaaakaafaaaaadabaaafia
aaaapeiaahaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaamoa
aaaaoeiappppaaaafdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 414
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 419
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.lmap);
    xlv_TEXCOORD1 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 422
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 424
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 428
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 432
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    #line 436
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD0);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
"!!ARBvp1.0
# 10 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[1].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[1].zw, R0;
MAD result.texcoord[0].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
"vs_2_0
; 10 ALU
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c8.x
mad oT1.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT1.zw, r0
mad oT0.xy, v2, c10, c10.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 8 vars
Vector 160 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcbbblengjeljhcopbdcfjhnhmjjdembcabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
alaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaaldccabaaa
abaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaaaaaaaaaa
akaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaa
afaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaaaaaaaaaa
aaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > (xlv_TEXCOORD1.z / xlv_TEXCOORD1.w))), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz);
  lm_12 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = vec3((tmpvar_6 * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 * min (lm_12, tmpvar_14));
  c_1.xyz = tmpvar_15;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = o_2;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD1);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD0);
  mediump vec3 lm_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((8.0 * tmpvar_7.w) * tmpvar_7.xyz);
  lm_8 = tmpvar_9;
  lowp vec3 arg1_10;
  arg1_10 = ((tmpvar_6.x * 2.0) * tmpvar_7.xyz);
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_2 * max (min (lm_8, arg1_10), (lm_8 * tmpvar_6.x)));
  c_1.xyz = tmpvar_11;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
Vector 10 [unity_LightmapST]
"agal_vs
c11 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaaalaaaaaaabaaaaaa mul r1.xyz, r0.xyww, c11.x
adaaaaaaabaaacacabaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r1.y, c8.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
adaaaaaaabaaadaeabaaaafeacaaaaaaajaaaaoeabaaaaaa mul v1.xy, r1.xyyy, c9
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaabaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v1.zw, r0.wwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a4, c10
abaaaaaaaaaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v0.xy, r0.xyyy, c10.zwzw
aaaaaaaaaaaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 176 // 176 used size, 8 vars
Vector 160 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedahbnkfohpkepegckbbidjciajmncepcpabaaaaaajmaeaaaaaeaaaaaa
daaaaaaaiiabaaaageadaaaacmaeaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
aeabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaakaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaaeaaaaaeaaaaadoa
aeaaoejaabaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiaahaaaakaafaaaaadabaaafia
aaaapeiaahaaaakaacaaaaadabaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaamoa
aaaaoeiappppaaaafdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaa
aaaaaaaaalaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
pccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaaakaaaaaaogikcaaa
aaaaaaaaakaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
abaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaacaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaacaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadamaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 423
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 414
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 419
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.lmap);
    xlv_TEXCOORD1 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 423
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 316
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 320
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 325
    return lm;
}
#line 344
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 346
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 423
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 427
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 431
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 435
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, false).xyz;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    #line 439
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD0);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Matrix 5 [_Object2World]
Vector 24 [unity_Scale]
"!!ARBvp1.0
# 56 ALU
PARAM c[25] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[24].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[10];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[9];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[11];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[12];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[19];
DP4 R2.y, R4, c[18];
DP4 R2.x, R4, c[17];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[14];
MAD R1.xyz, R0.x, c[13], R1;
MAD R0.xyz, R0.z, c[15], R1;
MAD R1.xyz, R0.w, c[16], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[22];
DP4 R4.z, R0, c[21];
DP4 R4.y, R0, c[20];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[23];
ADD R2.xyz, R2, R4.yzww;
ADD R0.xyz, R2, R0;
ADD result.texcoord[1].xyz, R0, R1;
MOV result.texcoord[0].z, R3.x;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R4;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 56 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_4LightPosX0]
Vector 9 [unity_4LightPosY0]
Vector 10 [unity_4LightPosZ0]
Vector 11 [unity_4LightAtten0]
Vector 12 [unity_LightColor0]
Vector 13 [unity_LightColor1]
Vector 14 [unity_LightColor2]
Vector 15 [unity_LightColor3]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Vector 23 [unity_Scale]
"vs_2_0
; 56 ALU
def c24, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r3.xyz, v1, c23.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c9
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c8
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c24.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c10
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c11
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c24.x
dp4 r2.z, r4, c18
dp4 r2.y, r4, c17
dp4 r2.x, r4, c16
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c24.y
mul r0, r0, r1
mul r1.xyz, r0.y, c13
mad r1.xyz, r0.x, c12, r1
mad r0.xyz, r0.z, c14, r1
mad r1.xyz, r0.w, c15, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c21
dp4 r4.z, r0, c20
dp4 r4.y, r0, c19
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c22
add r2.xyz, r2, r4.yzww
add r0.xyz, r2, r0
add oT1.xyz, r0, r1
mov oT0.z, r3.x
mov oT0.y, r3.w
mov oT0.x, r4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 46 instructions, 6 temp regs, 0 temp arrays:
// ALU 25 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedmbohmmcmbkiamjdnhndghhnhndlmcoijabaaaaaaoeahaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefchiagaaaaeaaaabaajoabaaaafjaaaaaeegiocaaaaaaaaaaa
bjaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacagaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficaabaaa
aaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaaaaaaaaa
bcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaaaaaaaaa
bdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaaaaaaaaa
beaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaa
egakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaaaaaaaaabfaaaaaa
egaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaaaaaaaaabgaaaaaa
egaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaaaaaaaaabhaaaaaa
egaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaa
adaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaa
dcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaadkaabaia
ebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaabiaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaihcaabaaaacaaaaaafgbfbaaa
aaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaafgafbaiaebaaaaaaacaaaaaa
egiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaaaeaaaaaafgafbaaaaaaaaaaa
egaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
adaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaiaebaaaaaaacaaaaaaegiocaaa
aaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaakgakbaiaebaaaaaaacaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaafaaaaaa
agaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaa
egaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaaadaaaaaadcaaaaajpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaaegaobaaaadaaaaaaeeaaaaaf
pcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaanpcaabaaaacaaaaaaegaobaaa
acaaaaaaegiocaaaaaaaaaaaafaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
acaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaaaaaaaaa
agaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaaegacbaaaacaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhccabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_6.w = 0.0;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_6.w = 0.0;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_4LightPosX0]
Vector 9 [unity_4LightPosY0]
Vector 10 [unity_4LightPosZ0]
Vector 11 [unity_4LightAtten0]
Vector 12 [unity_LightColor0]
Vector 13 [unity_LightColor1]
Vector 14 [unity_LightColor2]
Vector 15 [unity_LightColor3]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Matrix 4 [_Object2World]
Vector 23 [unity_Scale]
"agal_vs
c24 1.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaabhaaaappabaaaaaa mul r3.xyz, a1, c23.w
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaajaaaaoeabaaaaaa add r1, r1.x, c9
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaaiaaaaoeabaaaaaa add r0, r0.x, c8
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
aaaaaaaaaeaaaiacbiaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c24.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaaakaaaaoeabaaaaaa add r0, r0.y, c10
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaaalaaaaoeabaaaaaa mul r2, r1, c11
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaabiaaaaaaabaaaaaa add r1, r2, c24.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r2.z, r4, c18
bdaaaaaaacaaacacaeaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.y, r4, c17
bdaaaaaaacaaabacaeaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r2.x, r4, c16
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabiaaaaffabaaaaaa max r0, r0, c24.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaaanaaaaoeabaaaaaa mul r1.xyz, r0.y, c13
adaaaaaaafaaahacaaaaaaaaacaaaaaaamaaaaoeabaaaaaa mul r5.xyz, r0.x, c12
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaaaoaaaaoeabaaaaaa mul r0.xyz, r0.z, c14
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaaapaaaaoeabaaaaaa mul r1.xyz, r0.w, c15
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaaeaaaiacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r4.w, r0, c21
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r4.z, r0, c20
bdaaaaaaaeaaacacaaaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r4.y, r0, c19
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabgaaaaoeabaaaaaa mul r0.xyz, r1.w, c22
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaapjacaaaaaa add r2.xyz, r2.xyzz, r4.yzww
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v1.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.z, r3.x
aaaaaaaaaaaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.y, r3.w
aaaaaaaaaaaaabaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.x, r4.x
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 46 instructions, 6 temp regs, 0 temp arrays:
// ALU 25 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedndefckkolmlepdkhibemhlkfjhnefenbabaaaaaaaiamaaaaaeaaaaaa
daaaaaaafaaeaaaanaakaaaajialaaaaebgpgodjbiaeaaaabiaeaaaaaaacpopp
leadaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaacaa
aiaaabaaaaaaaaaaaaaabcaaahaaajaaaaaaaaaaabaaaaaaaeaabaaaaaaaaaaa
abaaamaaaeaabeaaaaaaaaaaabaabeaaabaabiaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbjaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaaaaaffjabfaaoeka
aeaaaaaeaaaaahiabeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaahiabgaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaahiabhaaoekaaaaappjaaaaaoeiaacaaaaad
abaaapiaaaaaffibacaaoekaafaaaaadacaaapiaabaaoeiaabaaoeiaacaaaaad
adaaapiaaaaaaaibabaaoekaacaaaaadaaaaapiaaaaakkibadaaoekaaeaaaaae
acaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaaeacaaapiaaaaaoeiaaaaaoeia
acaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaacaeaaaciaacaaffiaahaaaaac
aeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappiaabaaaaacafaaabiabjaaaaka
aeaaaaaeacaaapiaacaaoeiaaeaaoekaafaaaaiaafaaaaadafaaahiaacaaoeja
biaappkaafaaaaadagaaahiaafaaffiabfaaoekaaeaaaaaeafaaaliabeaakeka
afaaaaiaagaakeiaaeaaaaaeafaaahiabgaaoekaafaakkiaafaapeiaafaaaaad
abaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapiaadaaoeiaafaaaaiaabaaoeia
aeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeiaafaaaaadaaaaapiaaeaaoeia
aaaaoeiaalaaaaadaaaaapiaaaaaoeiabjaaffkaagaaaaacabaaabiaacaaaaia
agaaaaacabaaaciaacaaffiaagaaaaacabaaaeiaacaakkiaagaaaaacabaaaiia
acaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadabaaahiaaaaaffia
agaaoekaaeaaaaaeabaaahiaafaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahia
ahaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaappiaaaaaoeia
abaaaaacafaaaiiabjaaaakaajaaaaadabaaabiaajaaoekaafaaoeiaajaaaaad
abaaaciaakaaoekaafaaoeiaajaaaaadabaaaeiaalaaoekaafaaoeiaafaaaaad
acaaapiaafaacjiaafaakeiaajaaaaadadaaabiaamaaoekaacaaoeiaajaaaaad
adaaaciaanaaoekaacaaoeiaajaaaaadadaaaeiaaoaaoekaacaaoeiaacaaaaad
abaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiiaafaaffiaafaaffiaaeaaaaae
aaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaacaaaaahoaafaaoeiaaeaaaaae
abaaahiaapaaoekaaaaappiaabaaoeiaacaaaaadabaaahoaaaaaoeiaabaaoeia
afaaaaadaaaaapiaaaaaffjabbaaoekaaeaaaaaeaaaaapiabaaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiabcaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
bdaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeia
abaaaaacaaaaammaaaaaoeiappppaaaafdeieefchiagaaaaeaaaabaajoabaaaa
fjaaaaaeegiocaaaaaaaaaaabjaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
giaaaaacagaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaa
abaaaaaaegiocaaaaaaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaa
abaaaaaaegiocaaaaaaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaa
abaaaaaaegiocaaaaaaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaa
acaaaaaajgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaa
egiocaaaaaaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaa
egiocaaaaaaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaa
egiocaaaaaaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaadaaaaaadiaaaaahicaabaaaaaaaaaaabkaabaaa
aaaaaaaabkaabaaaaaaaaaaadcaaaaakicaabaaaaaaaaaaaakaabaaaaaaaaaaa
akaabaaaaaaaaaaadkaabaiaebaaaaaaaaaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaabiaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaai
hcaabaaaacaaaaaafgbfbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaabaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaa
acaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegacbaaaacaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaaabaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaa
fgafbaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaadaaaaaadiaaaaahpcaabaaa
aeaaaaaafgafbaaaaaaaaaaaegaobaaaadaaaaaadiaaaaahpcaabaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaadaaaaaaaaaaaaajpcaabaaaafaaaaaaagaabaia
ebaaaaaaacaaaaaaegiocaaaaaaaaaaaacaaaaaaaaaaaaajpcaabaaaacaaaaaa
kgakbaiaebaaaaaaacaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaajpcaabaaa
aeaaaaaaegaobaaaafaaaaaaagaabaaaaaaaaaaaegaobaaaaeaaaaaadcaaaaaj
pcaabaaaaaaaaaaaegaobaaaacaaaaaakgakbaaaaaaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaafaaaaaaegaobaaaafaaaaaaegaobaaa
adaaaaaadcaaaaajpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaadaaaaaaeeaaaaafpcaabaaaadaaaaaaegaobaaaacaaaaaadcaaaaan
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaafaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaacaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegaobaaaadaaaaaadeaaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaacaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaa
acaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaadcaaaaakhcaabaaa
acaaaaaaegiccaaaaaaaaaaaagaaaaaaagaabaaaaaaaaaaaegacbaaaacaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaakgakbaaaaaaaaaaa
egacbaaaacaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaaaaaaaaaajaaaaaa
pgapbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhccabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 415
#line 95
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 99
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 103
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 107
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 111
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 115
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 406
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 410
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 415
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 415
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 419
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 423
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = 1.0;
    #line 427
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 431
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Matrix 5 [_Object2World]
Vector 25 [unity_Scale]
"!!ARBvp1.0
# 62 ALU
PARAM c[26] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[25].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[10];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[12];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[13];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[20];
DP4 R2.y, R4, c[19];
DP4 R2.x, R4, c[18];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[15];
MAD R1.xyz, R0.x, c[14], R1;
MAD R0.xyz, R0.z, c[16], R1;
MAD R1.xyz, R0.w, c[17], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[23];
DP4 R4.z, R0, c[22];
DP4 R4.y, R0, c[21];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[24];
ADD R2.xyz, R2, R4.yzww;
ADD R4.yzw, R2.xxyz, R0.xxyz;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].z;
ADD result.texcoord[1].xyz, R4.yzww, R1;
MOV R1.x, R2;
MUL R1.y, R2, c[9].x;
ADD result.texcoord[2].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MOV result.texcoord[0].z, R3.x;
MOV result.texcoord[0].y, R3.w;
MOV result.texcoord[0].x, R4;
END
# 62 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Matrix 4 [_Object2World]
Vector 25 [unity_Scale]
"vs_2_0
; 62 ALU
def c26, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
mul r3.xyz, v1, c25.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c11
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c10
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c26.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c12
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c13
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c26.x
dp4 r2.z, r4, c20
dp4 r2.y, r4, c19
dp4 r2.x, r4, c18
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c26.y
mul r0, r0, r1
mul r1.xyz, r0.y, c15
mad r1.xyz, r0.x, c14, r1
mad r0.xyz, r0.z, c16, r1
mad r1.xyz, r0.w, c17, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c23
dp4 r4.z, r0, c22
dp4 r4.y, r0, c21
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c24
add r2.xyz, r2, r4.yzww
add r4.yzw, r2.xxyz, r0.xxyz
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c26.z
add oT1.xyz, r4.yzww, r1
mov r1.x, r2
mul r1.y, r2, c8.x
mad oT2.xy, r2.z, c9.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mov oT0.z, r3.x
mov oT0.y, r3.w
mov oT0.x, r4
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 51 instructions, 7 temp regs, 0 temp arrays:
// ALU 28 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedciakbjehflogeecghinmbcdjkkncipdmabaaaaaakeaiaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
caahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaae
egiocaaaabaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacahaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
hcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaai
hcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaak
lcaabaaaabaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaabaaaaaaegaibaaa
acaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaa
abaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaaabaaaaaaegacbaaaabaaaaaa
dgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaacaaaaaa
egiocaaaabaaaaaabcaaaaaaegaobaaaabaaaaaabbaaaaaiccaabaaaacaaaaaa
egiocaaaabaaaaaabdaaaaaaegaobaaaabaaaaaabbaaaaaiecaabaaaacaaaaaa
egiocaaaabaaaaaabeaaaaaaegaobaaaabaaaaaadiaaaaahpcaabaaaadaaaaaa
jgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaaibcaabaaaaeaaaaaaegiocaaa
abaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaaiccaabaaaaeaaaaaaegiocaaa
abaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaaiecaabaaaaeaaaaaaegiocaaa
abaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
acaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaaabaaaaaabkaabaaaabaaaaaa
bkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaaakaabaaaabaaaaaaakaabaaa
abaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaakhcaabaaaacaaaaaaegiccaaa
abaaaaaabiaaaaaapgapbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaihcaabaaa
adaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
adaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaadaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaajpcaabaaaaeaaaaaafgafbaia
ebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaadiaaaaahpcaabaaaafaaaaaa
fgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaahpcaabaaaaeaaaaaaegaobaaa
aeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaaagaaaaaaagaabaiaebaaaaaa
adaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaajpcaabaaaadaaaaaakgakbaia
ebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaadcaaaaajpcaabaaaafaaaaaa
egaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaaafaaaaaadcaaaaajpcaabaaa
abaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaaegaobaaaafaaaaaadcaaaaaj
pcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaaagaaaaaaegaobaaaaeaaaaaa
dcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaaegaobaaaadaaaaaaegaobaaa
aeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaaadaaaaaadcaaaaanpcaabaaa
adaaaaaaegaobaaaadaaaaaaegiocaaaabaaaaaaafaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaadiaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaakpcaabaaaabaaaaaaegaobaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaadiaaaaaihcaabaaaadaaaaaa
fgafbaaaabaaaaaaegiccaaaabaaaaaaahaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaabaaaaaaagaaaaaaagaabaaaabaaaaaaegacbaaaadaaaaaadcaaaaak
hcaabaaaabaaaaaaegiccaaaabaaaaaaaiaaaaaakgakbaaaabaaaaaaegacbaaa
adaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaajaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaa
aaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaadaaaaaakgaobaaa
aaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w))), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * tmpvar_6) * 2.0));
  c_12.w = 0.0;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (glstate_matrix_mvp * _glesVertex);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_23;
  tmpvar_23 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - tmpvar_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - tmpvar_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - tmpvar_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z)) * inversesqrt(tmpvar_27))) * (1.0/((1.0 + (tmpvar_27 * unity_4LightAtten0)))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y)) + (unity_LightColor[2].xyz * tmpvar_28.z)) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  highp vec4 o_30;
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_31.x;
  tmpvar_32.y = (tmpvar_31.y * _ProjectionParams.x);
  o_30.xy = (tmpvar_32 + tmpvar_31.w);
  o_30.zw = tmpvar_4.zw;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = o_30;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x) * 2.0));
  c_6.w = 0.0;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Matrix 4 [_Object2World]
Vector 24 [unity_Scale]
Vector 25 [unity_NPOTScale]
"agal_vs
c26 1.0 0.0 0.5 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaabiaaaappabaaaaaa mul r3.xyz, a1, c24.w
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaakaaaaoeabaaaaaa add r1, r1.x, c10
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaajaaaaoeabaaaaaa add r0, r0.x, c9
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
aaaaaaaaaeaaaiacbkaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c26.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaaalaaaaoeabaaaaaa add r0, r0.y, c11
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaaamaaaaoeabaaaaaa mul r2, r1, c12
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaabkaaaaaaabaaaaaa add r1, r2, c26.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r2.z, r4, c19
bdaaaaaaacaaacacaeaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r2.y, r4, c18
bdaaaaaaacaaabacaeaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.x, r4, c17
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabkaaaaffabaaaaaa max r0, r0, c26.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaaaoaaaaoeabaaaaaa mul r1.xyz, r0.y, c14
adaaaaaaafaaahacaaaaaaaaacaaaaaaanaaaaoeabaaaaaa mul r5.xyz, r0.x, c13
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaaapaaaaoeabaaaaaa mul r0.xyz, r0.z, c15
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabaaaaaoeabaaaaaa mul r1.xyz, r0.w, c16
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaaeaaaiacaaaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r4.w, r0, c22
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r4.z, r0, c21
bdaaaaaaaeaaacacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r4.y, r0, c20
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabhaaaaoeabaaaaaa mul r0.xyz, r1.w, c23
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaapjacaaaaaa add r2.xyz, r2.xyzz, r4.yzww
abaaaaaaacaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r2.xyz, r2.xyzz, r0.xyzz
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaaeaaaoacaaaaaandacaaaaaabkaaaakkabaaaaaa mul r4.yzw, r0.wxyw, c26.z
abaaaaaaabaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v1.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaacacaeaaaakkacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r4.z, c8.x
aaaaaaaaabaaabacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r4.y
abaaaaaaabaaadacabaaaafeacaaaaaaaeaaaappacaaaaaa add r1.xy, r1.xyyy, r4.w
adaaaaaaacaaadaeabaaaafeacaaaaaabjaaaaoeabaaaaaa mul v2.xy, r1.xyyy, c25
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaacaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, r0.wwzw
aaaaaaaaaaaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.z, r3.x
aaaaaaaaaaaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v0.y, r3.w
aaaaaaaaaaaaabaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v0.x, r4.x
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 32 [unity_4LightPosX0] 4
Vector 48 [unity_4LightPosY0] 4
Vector 64 [unity_4LightPosZ0] 4
Vector 80 [unity_4LightAtten0] 4
Vector 96 [unity_LightColor0] 4
Vector 112 [unity_LightColor1] 4
Vector 128 [unity_LightColor2] 4
Vector 144 [unity_LightColor3] 4
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 51 instructions, 7 temp regs, 0 temp arrays:
// ALU 28 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedmgpfpojjeiciaefpjlahpifooanganelabaaaaaacaanaaaaaeaaaaaa
daaaaaaakiaeaaaanaalaaaajiamaaaaebgpgodjhaaeaaaahaaeaaaaaaacpopp
aaaeaaaahaaaaaaaagaaceaaaaaagmaaaaaagmaaaaaaceaaabaagmaaaaaaafaa
abaaabaaaaaaaaaaabaaacaaaiaaacaaaaaaaaaaabaabcaaahaaakaaaaaaaaaa
acaaaaaaaeaabbaaaaaaaaaaacaaamaaaeaabfaaaaaaaaaaacaabeaaabaabjaa
aaaaaaaaaaaaaaaaaaacpoppfbaaaaafbkaaapkaaaaaiadpaaaaaaaaaaaaaadp
aaaaaaaabpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaad
aaaaahiaaaaaffjabgaaoekaaeaaaaaeaaaaahiabfaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaahiabhaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahiabiaaoeka
aaaappjaaaaaoeiaacaaaaadabaaapiaaaaaffibadaaoekaafaaaaadacaaapia
abaaoeiaabaaoeiaacaaaaadadaaapiaaaaaaaibacaaoekaacaaaaadaaaaapia
aaaakkibaeaaoekaaeaaaaaeacaaapiaadaaoeiaadaaoeiaacaaoeiaaeaaaaae
acaaapiaaaaaoeiaaaaaoeiaacaaoeiaahaaaaacaeaaabiaacaaaaiaahaaaaac
aeaaaciaacaaffiaahaaaaacaeaaaeiaacaakkiaahaaaaacaeaaaiiaacaappia
abaaaaacafaaabiabkaaaakaaeaaaaaeacaaapiaacaaoeiaafaaoekaafaaaaia
afaaaaadafaaahiaacaaoejabjaappkaafaaaaadagaaahiaafaaffiabgaaoeka
aeaaaaaeafaaaliabfaakekaafaaaaiaagaakeiaaeaaaaaeafaaahiabhaaoeka
afaakkiaafaapeiaafaaaaadabaaapiaabaaoeiaafaaffiaaeaaaaaeabaaapia
adaaoeiaafaaaaiaabaaoeiaaeaaaaaeaaaaapiaaaaaoeiaafaakkiaabaaoeia
afaaaaadaaaaapiaaeaaoeiaaaaaoeiaalaaaaadaaaaapiaaaaaoeiabkaaffka
agaaaaacabaaabiaacaaaaiaagaaaaacabaaaciaacaaffiaagaaaaacabaaaeia
acaakkiaagaaaaacabaaaiiaacaappiaafaaaaadaaaaapiaaaaaoeiaabaaoeia
afaaaaadabaaahiaaaaaffiaahaaoekaaeaaaaaeabaaahiaagaaoekaaaaaaaia
abaaoeiaaeaaaaaeaaaaahiaaiaaoekaaaaakkiaabaaoeiaaeaaaaaeaaaaahia
ajaaoekaaaaappiaaaaaoeiaabaaaaacafaaaiiabkaaaakaajaaaaadabaaabia
akaaoekaafaaoeiaajaaaaadabaaaciaalaaoekaafaaoeiaajaaaaadabaaaeia
amaaoekaafaaoeiaafaaaaadacaaapiaafaacjiaafaakeiaajaaaaadadaaabia
anaaoekaacaaoeiaajaaaaadadaaaciaaoaaoekaacaaoeiaajaaaaadadaaaeia
apaaoekaacaaoeiaacaaaaadabaaahiaabaaoeiaadaaoeiaafaaaaadaaaaaiia
afaaffiaafaaffiaaeaaaaaeaaaaaiiaafaaaaiaafaaaaiaaaaappibabaaaaac
aaaaahoaafaaoeiaaeaaaaaeabaaahiabaaaoekaaaaappiaabaaoeiaacaaaaad
abaaahoaaaaaoeiaabaaoeiaafaaaaadaaaaapiaaaaaffjabcaaoekaaeaaaaae
aaaaapiabbaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiabdaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiabeaaoekaaaaappjaaaaaoeiaafaaaaadabaaabia
aaaaffiaabaaaakaafaaaaadabaaaiiaabaaaaiabkaakkkaafaaaaadabaaafia
aaaapeiabkaakkkaacaaaaadacaaadoaabaakkiaabaaomiaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacacaaamoa
aaaaoeiappppaaaafdeieefccaahaaaaeaaaabaamiabaaaafjaaaaaeegiocaaa
aaaaaaaaagaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafjaaaaaeegiocaaa
acaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaad
hccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacahaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaacaaaaaafgafbaaaabaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaabaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaabaaaaaaegaibaaaacaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaabaaaaaaegadbaaaabaaaaaadgaaaaafhccabaaa
abaaaaaaegacbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaabeaaaaaaaaaiadp
bbaaaaaibcaabaaaacaaaaaaegiocaaaabaaaaaabcaaaaaaegaobaaaabaaaaaa
bbaaaaaiccaabaaaacaaaaaaegiocaaaabaaaaaabdaaaaaaegaobaaaabaaaaaa
bbaaaaaiecaabaaaacaaaaaaegiocaaaabaaaaaabeaaaaaaegaobaaaabaaaaaa
diaaaaahpcaabaaaadaaaaaajgacbaaaabaaaaaaegakbaaaabaaaaaabbaaaaai
bcaabaaaaeaaaaaaegiocaaaabaaaaaabfaaaaaaegaobaaaadaaaaaabbaaaaai
ccaabaaaaeaaaaaaegiocaaaabaaaaaabgaaaaaaegaobaaaadaaaaaabbaaaaai
ecaabaaaaeaaaaaaegiocaaaabaaaaaabhaaaaaaegaobaaaadaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaaeaaaaaadiaaaaahicaabaaa
abaaaaaabkaabaaaabaaaaaabkaabaaaabaaaaaadcaaaaakicaabaaaabaaaaaa
akaabaaaabaaaaaaakaabaaaabaaaaaadkaabaiaebaaaaaaabaaaaaadcaaaaak
hcaabaaaacaaaaaaegiccaaaabaaaaaabiaaaaaapgapbaaaabaaaaaaegacbaaa
acaaaaaadiaaaaaihcaabaaaadaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaa
aaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaaegiccaaaacaaaaaa
aoaaaaaakgbkbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaadaaaaaa
egiccaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaaj
pcaabaaaaeaaaaaafgafbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaadaaaaaa
diaaaaahpcaabaaaafaaaaaafgafbaaaabaaaaaaegaobaaaaeaaaaaadiaaaaah
pcaabaaaaeaaaaaaegaobaaaaeaaaaaaegaobaaaaeaaaaaaaaaaaaajpcaabaaa
agaaaaaaagaabaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaacaaaaaaaaaaaaaj
pcaabaaaadaaaaaakgakbaiaebaaaaaaadaaaaaaegiocaaaabaaaaaaaeaaaaaa
dcaaaaajpcaabaaaafaaaaaaegaobaaaagaaaaaaagaabaaaabaaaaaaegaobaaa
afaaaaaadcaaaaajpcaabaaaabaaaaaaegaobaaaadaaaaaakgakbaaaabaaaaaa
egaobaaaafaaaaaadcaaaaajpcaabaaaaeaaaaaaegaobaaaagaaaaaaegaobaaa
agaaaaaaegaobaaaaeaaaaaadcaaaaajpcaabaaaadaaaaaaegaobaaaadaaaaaa
egaobaaaadaaaaaaegaobaaaaeaaaaaaeeaaaaafpcaabaaaaeaaaaaaegaobaaa
adaaaaaadcaaaaanpcaabaaaadaaaaaaegaobaaaadaaaaaaegiocaaaabaaaaaa
afaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpaoaaaaakpcaabaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegaobaaaadaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaaeaaaaaadeaaaaak
pcaabaaaabaaaaaaegaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaadaaaaaaegaobaaaabaaaaaa
diaaaaaihcaabaaaadaaaaaafgafbaaaabaaaaaaegiccaaaabaaaaaaahaaaaaa
dcaaaaakhcaabaaaadaaaaaaegiccaaaabaaaaaaagaaaaaaagaabaaaabaaaaaa
egacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaabaaaaaaaiaaaaaa
kgakbaaaabaaaaaaegacbaaaadaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaa
abaaaaaaajaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaaaaaaaahhccabaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaadaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaadaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 95
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 99
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 103
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 107
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 111
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 115
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 415
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 419
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 423
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform sampler2D _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    highp float dist = textureProj( _ShadowMapTexture, shadowCoord).x;
    mediump float lightShadowDataX = _LightShadowData.x;
    #line 388
    return max( float((dist > (shadowCoord.z / shadowCoord.w))), lightShadowDataX);
}
#line 425
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 427
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 431
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 435
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    #line 439
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * shadow_6) * 2.0));
  c_9.w = 0.0;
  c_1.w = c_9.w;
  c_1.xyz = (c_9.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 423
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 415
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 419
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 423
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 423
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 427
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 431
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    #line 435
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    #line 439
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz), vec3((shadow_6 * 2.0))));
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 414
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 419
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.lmap);
    xlv_TEXCOORD1 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 422
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 424
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 428
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 432
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec3 lm = DecodeLightmap( lmtex);
    #line 436
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD0);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD1 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform highp vec4 _LightShadowData;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD1.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD0).xyz);
  lm_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = vec3((shadow_6 * 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 * min (lm_9, tmpvar_11));
  c_1.xyz = tmpvar_12;
  c_1.w = 0.0;
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" "SHADOWS_NATIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 423
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 414
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 419
    return o;
}

out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec2(xl_retval.lmap);
    xlv_TEXCOORD1 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    highp vec2 lmap;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 410
uniform highp vec4 unity_LightmapST;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
#line 423
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 316
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 320
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 325
    return lm;
}
#line 344
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 346
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 423
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 427
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 431
    o.Gloss = 0.0;
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    #line 435
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec3 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, false).xyz;
    c.xyz += (o.Albedo * min( lm, vec3( (atten * 2.0))));
    #line 439
    c.w = o.Alpha;
    c.xyz += o.Emission;
    return c;
}
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD0);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_5;
  mediump vec3 tmpvar_7;
  mediump vec4 normal_8;
  normal_8 = tmpvar_6;
  highp float vC_9;
  mediump vec3 x3_10;
  mediump vec3 x2_11;
  mediump vec3 x1_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHAr, normal_8);
  x1_12.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAg, normal_8);
  x1_12.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAb, normal_8);
  x1_12.z = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (normal_8.xyzz * normal_8.yzzx);
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHBr, tmpvar_16);
  x2_11.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBg, tmpvar_16);
  x2_11.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBb, tmpvar_16);
  x2_11.z = tmpvar_19;
  mediump float tmpvar_20;
  tmpvar_20 = ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y));
  vC_9 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (unity_SHC.xyz * vC_9);
  x3_10 = tmpvar_21;
  tmpvar_7 = ((x1_12 + x2_11) + x3_10);
  shlight_1 = tmpvar_7;
  tmpvar_3 = shlight_1;
  highp vec3 tmpvar_22;
  tmpvar_22 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosX0 - tmpvar_22.x);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosY0 - tmpvar_22.y);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosZ0 - tmpvar_22.z);
  highp vec4 tmpvar_26;
  tmpvar_26 = (((tmpvar_23 * tmpvar_23) + (tmpvar_24 * tmpvar_24)) + (tmpvar_25 * tmpvar_25));
  highp vec4 tmpvar_27;
  tmpvar_27 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_23 * tmpvar_5.x) + (tmpvar_24 * tmpvar_5.y)) + (tmpvar_25 * tmpvar_5.z)) * inversesqrt(tmpvar_26))) * (1.0/((1.0 + (tmpvar_26 * unity_4LightAtten0)))));
  highp vec3 tmpvar_28;
  tmpvar_28 = (tmpvar_3 + ((((unity_LightColor[0].xyz * tmpvar_27.x) + (unity_LightColor[1].xyz * tmpvar_27.y)) + (unity_LightColor[2].xyz * tmpvar_27.z)) + (unity_LightColor[3].xyz * tmpvar_27.w)));
  tmpvar_3 = tmpvar_28;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
varying highp vec4 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _WorldSpaceLightPos0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _Emission.xyz;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, _WorldSpaceLightPos0.xyz)) * shadow_6) * 2.0));
  c_9.w = 0.0;
  c_1.w = c_9.w;
  c_1.xyz = (c_9.xyz + (tmpvar_2 * xlv_TEXCOORD1));
  c_1.xyz = (c_1.xyz + tmpvar_3);
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 95
highp vec3 Shade4PointLights( in highp vec4 lightPosX, in highp vec4 lightPosY, in highp vec4 lightPosZ, in highp vec3 lightColor0, in highp vec3 lightColor1, in highp vec3 lightColor2, in highp vec3 lightColor3, in highp vec4 lightAttenSq, in highp vec3 pos, in highp vec3 normal ) {
    highp vec4 toLightX = (lightPosX - pos.x);
    highp vec4 toLightY = (lightPosY - pos.y);
    #line 99
    highp vec4 toLightZ = (lightPosZ - pos.z);
    highp vec4 lengthSq = vec4( 0.0);
    lengthSq += (toLightX * toLightX);
    lengthSq += (toLightY * toLightY);
    #line 103
    lengthSq += (toLightZ * toLightZ);
    highp vec4 ndotl = vec4( 0.0);
    ndotl += (toLightX * normal.x);
    ndotl += (toLightY * normal.y);
    #line 107
    ndotl += (toLightZ * normal.z);
    highp vec4 corr = inversesqrt(lengthSq);
    ndotl = max( vec4( 0.0, 0.0, 0.0, 0.0), (ndotl * corr));
    highp vec4 atten = (1.0 / (1.0 + (lengthSq * lightAttenSq)));
    #line 111
    highp vec4 diff = (ndotl * atten);
    highp vec3 col = vec3( 0.0);
    col += (lightColor0 * diff.x);
    col += (lightColor1 * diff.y);
    #line 115
    col += (lightColor2 * diff.z);
    col += (lightColor3 * diff.w);
    return col;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 411
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 415
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.normal = worldN;
    highp vec3 shlight = ShadeSH9( vec4( worldN, 1.0));
    o.vlight = shlight;
    #line 419
    highp vec3 worldPos = (_Object2World * v.vertex).xyz;
    o.vlight += Shade4PointLights( unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0, unity_LightColor[0].xyz, unity_LightColor[1].xyz, unity_LightColor[2].xyz, unity_LightColor[3].xyz, unity_4LightAtten0, worldPos, worldN);
    o._ShadowCoord = (unity_World2Shadow[0] * (_Object2World * v.vertex));
    #line 423
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
    xlv_TEXCOORD2 = vec4(xl_retval._ShadowCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_shadow2D(mediump sampler2DShadow s, vec3 coord) { return texture (s, coord); }
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 390
struct Input {
    highp vec3 worldPos;
};
#line 403
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    lowp vec3 vlight;
    highp vec4 _ShadowCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform highp vec4 _ShadowOffsets[4];
uniform lowp sampler2DShadow _ShadowMapTexture;
#line 384
#line 395
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 411
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 398
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 400
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 384
lowp float unitySampleShadow( in highp vec4 shadowCoord ) {
    lowp float shadow = xll_shadow2D( _ShadowMapTexture, shadowCoord.xyz.xyz);
    shadow = (_LightShadowData.x + (shadow * (1.0 - _LightShadowData.x)));
    #line 388
    return shadow;
}
#line 425
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 427
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 431
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 435
    surf( surfIN, o);
    lowp float atten = unitySampleShadow( IN._ShadowCoord);
    lowp vec4 c = vec4( 0.0);
    c = LightingLambert( o, _WorldSpaceLightPos0.xyz, atten);
    #line 439
    c.xyz += (o.Albedo * IN.vlight);
    c.xyz += o.Emission;
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xlt_IN._ShadowCoord = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 6 to 12, TEX: 0 to 2
//   d3d9 - ALU: 6 to 11, TEX: 1 to 2
//   d3d11 - ALU: 2 to 8, TEX: 0 to 2, FLOW: 1 to 1
//   d3d11_9x - ALU: 2 to 8, TEX: 0 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Emission]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 9 ALU, 0 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
MOV R0.xyz, c[1];
DP3 R0.w, fragment.texcoord[0], c[0];
MUL R1.xyz, fragment.texcoord[1], c[2];
MUL R0.xyz, R0, c[2];
MAX R0.w, R0, c[4].x;
MUL R0.xyz, R0.w, R0;
MAD R0.xyz, R0, c[4].y, R1;
ADD result.color.xyz, R0, c[3];
MOV result.color.w, c[4].x;
END
# 9 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Emission]
"ps_2_0
; 10 ALU
def c4, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
mov_pp r1.xyz, c2
dp3_pp r0.x, t0, c0
mul_pp r2.xyz, t1, c2
mul_pp r1.xyz, c1, r1
max_pp r0.x, r0, c4
mul_pp r0.xyz, r0.x, r1
mad_pp r0.xyz, r0, c4.y, r2
mov_pp r0.w, c4.x
add_pp r0.xyz, r0, c3
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 96 // 80 used size, 6 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecednfhebjcldehjpblhehlfjibmjdehonpnabaaaaaaceacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcemabaaaaeaaaaaaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Emission]
"agal_ps
c4 0.0 2.0 0.0 0.0
[bc]
aaaaaaaaabaaahacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c2
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v0, c0
adaaaaaaacaaahacabaaaaoeaeaaaaaaacaaaaoeabaaaaaa mul r2.xyz, v1, c2
adaaaaaaabaaahacabaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c1, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaaoeabaaaaaa max r0.x, r0.x, c4
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaeaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c4.y
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
aaaaaaaaaaaaaiacaeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c4.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaaoeabaaaaaa add r0.xyz, r0.xyzz, c3
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 96 // 80 used size, 6 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 6 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedllfapbhkgbeaaioacbnoeeodikomcnkmabaaaaaaeiadaaaaaeaaaaaa
daaaaaaafaabaaaakeacaaaabeadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
naaaaaaaeiaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaaaaaeiaaaaaaabaa
abaaaaaaaaaaaaaaaaaaadaaacaaabaaaaaaaaaaabaaaaaaabaaadaaaaaaaaaa
aaacppppfbaaaaafaeaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaachlabpaaaaacaaaaaaiaabaachlaaiaaaaadaaaaciiaaaaaoela
adaaoekaalaaaaadabaaciiaaaaappiaaeaaaakaacaaaaadaaaacbiaabaappia
abaappiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablka
afaaaaadabaachiaabaaoelaabaaoekaaeaaaaaeaaaachiaaaaabliaaaaaaaia
abaaoeiaacaaaaadaaaachiaaaaaoeiaacaaoekaabaaaaacaaaaaiiaaeaaaaka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcemabaaaaeaaaaaaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaabaaaaaaibcaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaadaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaa
aaaaaaaaadaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0.w, R0;
MOV R1.xyz, c[1];
MUL R0.xyz, R0, c[0];
MAD result.color.xyz, R0, c[2].y, R1;
MOV result.color.w, c[2].x;
END
# 6 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [unity_Lightmap] 2D
"ps_2_0
; 6 ALU, 1 TEX
dcl_2d s0
def c2, 8.00000000, 0.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r0, c0
mov_pp r0.xyz, c1
mov_pp r0.w, c2.y
mad_pp r0.xyz, r1, c2.x, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [unity_Lightmap] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedklodiplgibollkcgigffmjhjnfihigmlabaaaaaaleabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaa
eaaaaaaadnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [unity_Lightmap] 2D
"agal_ps
c2 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
aaaaaaaaaaaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c1
aaaaaaaaaaaaaiacacaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.y
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c2.x
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [unity_Lightmap] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefieceddgonepjdnndbonhchohcoamcnckmpcbkabaaaaaajeacaaaaaeaaaaaa
daaaaaaaamabaaaaaiacaaaagaacaaaaebgpgodjneaaaaaaneaaaaaaaaacpppp
kaaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaebaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaacaaaaka
afaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacabaaahiaaaaaoekaaeaaaaae
aaaachiaabaaoeiaaaaaoeiaabaaoekaabaaaaacaaaaciiaacaaffkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 6 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0.w, R0;
MOV R1.xyz, c[1];
MUL R0.xyz, R0, c[0];
MAD result.color.xyz, R0, c[2].y, R1;
MOV result.color.w, c[2].x;
END
# 6 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [unity_Lightmap] 2D
"ps_2_0
; 6 ALU, 1 TEX
dcl_2d s0
def c2, 8.00000000, 0.00000000, 0, 0
dcl t0.xy
texld r0, t0, s0
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r0, c0
mov_pp r0.xyz, c1
mov_pp r0.w, c2.y
mad_pp r0.xyz, r1, c2.x, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [unity_Lightmap] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedklodiplgibollkcgigffmjhjnfihigmlabaaaaaaleabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaa
eaaaaaaadnaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaapgapbaaaaaaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [unity_Lightmap] 2D
"agal_ps
c2 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaabaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r0.xyzz, c0
aaaaaaaaaaaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c1
aaaaaaaaaaaaaiacacaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.y
adaaaaaaabaaahacabaaaakeacaaaaaaacaaaaaaabaaaaaa mul r1.xyz, r1.xyzz, c2.x
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [unity_Lightmap] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefieceddgonepjdnndbonhchohcoamcnckmpcbkabaaaaaajeacaaaaaeaaaaaa
daaaaaaaamabaaaaaiacaaaagaacaaaaebgpgodjneaaaaaaneaaaaaaaaacpppp
kaaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaebaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaacaaaaka
afaaaaadaaaachiaaaaaoeiaaaaappiaabaaaaacabaaahiaaaaaoekaaeaaaaae
aaaachiaabaaoeiaaaaaoeiaabaaoekaabaaaaacaaaaciiaacaaffkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
abeaaaaaaaaaaaebdiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaapgapbaaa
aaaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 1 TEX
PARAM c[5] = { program.local[0..3],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TXP R0.x, fragment.texcoord[2], texture[0], 2D;
MOV R1.xyz, c[1];
DP3 R1.w, fragment.texcoord[0], c[0];
MAX R1.w, R1, c[4].x;
MUL R0.x, R1.w, R0;
MUL R1.xyz, R1, c[2];
MUL R0.yzw, fragment.texcoord[1].xxyz, c[2].xxyz;
MUL R1.xyz, R0.x, R1;
MAD R0.xyz, R1, c[4].y, R0.yzww;
ADD result.color.xyz, R0, c[3];
MOV result.color.w, c[4].x;
END
# 11 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
"ps_2_0
; 11 ALU, 1 TEX
dcl_2d s0
def c4, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
texldp r2, t2, s0
dp3_pp r0.x, t0, c0
mov_pp r1.xyz, c2
max_pp r0.x, r0, c4
mul_pp r0.x, r0, r2
mul_pp r1.xyz, c1, r1
mul_pp r2.xyz, t1, c2
mul_pp r0.xyz, r0.x, r1
mad_pp r0.xyz, r0, c4.y, r2
mov_pp r0.w, c4.x
add_pp r0.xyz, r0, c3
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 160 // 144 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_Emission] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_ShadowMapTexture] 2D 0
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedghnlfjoaehhkebjicedicgiabfoclaomabaaaaaakeacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcleabaaaaeaaaaaaagnaaaaaafjaaaaaeegiocaaa
aaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaa
gcbaaaadhcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaaabaaaaaa
egiccaaaabaaaaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
abeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaaagaabaaa
aaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaaegiccaaa
aaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaaaaaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaaiaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
"agal_ps
c4 0.0 2.0 0.0 0.0
[bc]
aeaaaaaaaaaaapacacaaaaoeaeaaaaaaacaaaappaeaaaaaa div r0, v2, v2.w
ciaaaaaaacaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r2, r0.xyyy, s0 <2d wrap linear point>
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v0, c0
aaaaaaaaabaaahacacaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c2
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaaoeabaaaaaa max r0.x, r0.x, c4
adaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r0.x, r0.x, r2.x
adaaaaaaabaaahacabaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c1, r1.xyzz
adaaaaaaacaaahacabaaaaoeaeaaaaaaacaaaaoeabaaaaaa mul r2.xyz, v1, c2
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaeaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c4.y
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
aaaaaaaaaaaaaiacaeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c4.x
abaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaaoeabaaaaaa add r0.xyz, r0.xyzz, c3
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 160 // 144 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
Vector 128 [_Emission] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
SetTexture 0 [_ShadowMapTexture] 2D 0
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecediceffcaflfdbkhfpkieeadbhicldkkflabaaaaaaceaeaaaaaeaaaaaa
daaaaaaakmabaaaagiadaaaapaadaaaaebgpgodjheabaaaaheabaaaaaaacpppp
ciabaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaahaaacaaabaaaaaaaaaaabaaaaaaabaaadaa
aaaaaaaaaaacppppfbaaaaafaeaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaachlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkaagaaaaacaaaaaiiaacaapplaafaaaaad
aaaaadiaaaaappiaacaaoelaecaaaaadaaaacpiaaaaaoeiaaaaioekaaiaaaaad
aaaacciaaaaaoelaadaaoekaafaaaaadaaaacbiaaaaaaaiaaaaaffiafiaaaaae
aaaacbiaaaaaffiaaaaaaaiaaeaaaakaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
abaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablkaafaaaaad
abaachiaabaaoelaabaaoekaaeaaaaaeaaaachiaaaaabliaaaaaaaiaabaaoeia
acaaaaadaaaachiaaaaaoeiaacaaoekaabaaaaacaaaaciiaaeaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcleabaaaaeaaaaaaagnaaaaaafjaaaaae
egiocaaaaaaaaaaaajaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadhcbabaaa
abaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaaiccaabaaaaaaaaaaaegbcbaaa
abaaaaaaegiccaaaabaaaaaaaaaaaaaadeaaaaahccaabaaaaaaaaaaabkaabaaa
aaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaafgafbaaaaaaaaaaa
agaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaa
agijcaaaaaaaaaaaahaaaaaadiaaaaaihcaabaaaabaaaaaaegbcbaaaacaaaaaa
egiccaaaaaaaaaaaahaaaaaadcaaaaajhcaabaaaaaaaaaaajgahbaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaaaaaaaaaihccabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaaiaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R1.xyz, R0, R2.x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[2].y;
MUL R1.xyz, R1, c[2].z;
MIN R1.xyz, R0, R1;
MUL R0.xyz, R0, R2.x;
MOV R2.xyz, c[1];
MAX R0.xyz, R1, R0;
MAD result.color.xyz, R0, c[0], R2;
MOV result.color.w, c[2].x;
END
# 12 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 11 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0.xy
dcl t1
texldp r1, t1, s0
texld r0, t0, s1
mul_pp r2.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r2.xyz, r2, c2.x
mul_pp r0.xyz, r0, c2.y
min_pp r0.xyz, r2, r0
mul_pp r1.xyz, r2, r1.x
max_pp r1.xyz, r0, r1
mov_pp r0.xyz, c1
mov_pp r0.w, c2.z
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 144 used size, 8 vars
Vector 112 [_Color] 4
Vector 128 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedceoimnekidnegdeomkejaddjmcaagppjabaaaaaamaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiabaaaaeaaaaaaahkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"agal_ps
c2 8.0 2.0 0.0 0.0
[bc]
aeaaaaaaaaaaapacabaaaaoeaeaaaaaaabaaaappaeaaaaaa div r0, v1, v1.w
ciaaaaaaabaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r0.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaacaaaaaa mul r0.xyz, r0.xyzz, r1.x
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaaaabaaaaaa mul r2.xyz, r2.xyzz, c2.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
agaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa min r0.xyz, r2.xyzz, r0.xyzz
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
ahaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa max r1.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c1
aaaaaaaaaaaaaiacacaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.z
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 144 used size, 8 vars
Vector 112 [_Color] 4
Vector 128 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedaeadpnkmdaeikkmhegolgofbngcfleddabaaaaaadiaeaaaaaeaaaaaa
daaaaaaakeabaaaajeadaaaaaeaeaaaaebgpgodjgmabaaaagmabaaaaaaacpppp
deabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaahaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaaaaaoelaabaioekaacaaaaadaaaaccia
aaaaaaiaaaaaaaiaafaaaaadaaaacoiaabaabliaaaaaffiaafaaaaadabaaciia
abaappiaacaaaakaafaaaaadabaachiaabaaoeiaabaappiaakaaaaadacaachia
aaaabliaabaaoeiaafaaaaadaaaachiaaaaaaaiaabaaoeiaalaaaaadabaachia
acaaoeiaaaaaoeiaabaaaaacaaaaahiaaaaaoekaaeaaaaaeaaaachiaaaaaoeia
abaaoeiaabaaoekaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoiabaaaaeaaaaaaahkaaaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.x, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[1], 2D;
MUL R1.xyz, R0, R2.x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[2].y;
MUL R1.xyz, R1, c[2].z;
MIN R1.xyz, R0, R1;
MUL R0.xyz, R0, R2.x;
MOV R2.xyz, c[1];
MAX R0.xyz, R1, R0;
MAD result.color.xyz, R0, c[0], R2;
MOV result.color.w, c[2].x;
END
# 12 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 11 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0.xy
dcl t1
texldp r1, t1, s0
texld r0, t0, s1
mul_pp r2.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r2.xyz, r2, c2.x
mul_pp r0.xyz, r0, c2.y
min_pp r0.xyz, r2, r0
mul_pp r1.xyz, r2, r1.x
max_pp r1.xyz, r0, r1
mov_pp r0.xyz, c1
mov_pp r0.w, c2.z
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 144 used size, 8 vars
Vector 112 [_Color] 4
Vector 128 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedceoimnekidnegdeomkejaddjmcaagppjabaaaaaamaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoiabaaaaeaaaaaaahkaaaaaa
fjaaaaaeegiocaaaaaaaaaaaajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdiaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
pgapbaaaabaaaaaaddaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahhcaabaaaabaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hccabaaaaaaaaaaaegiccaaaaaaaaaaaahaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaiaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_ShadowMapTexture] 2D
SetTexture 1 [unity_Lightmap] 2D
"agal_ps
c2 8.0 2.0 0.0 0.0
[bc]
aeaaaaaaaaaaapacabaaaaoeaeaaaaaaabaaaappaeaaaaaa div r0, v1, v1.w
ciaaaaaaabaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r0.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaaoeaeaaaaaaabaaaaaaafaababb tex r0, v0, s1 <2d wrap linear point>
adaaaaaaacaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r2.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaacaaaaaa mul r0.xyz, r0.xyzz, r1.x
adaaaaaaacaaahacacaaaakeacaaaaaaacaaaaaaabaaaaaa mul r2.xyz, r2.xyzz, c2.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
agaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa min r0.xyz, r2.xyzz, r0.xyzz
adaaaaaaabaaahacacaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r2.xyzz, r1.x
ahaaaaaaabaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa max r1.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, c1
aaaaaaaaaaaaaiacacaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.z
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
abaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
ConstBuffer "$Globals" 176 // 144 used size, 8 vars
Vector 112 [_Color] 4
Vector 128 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_ShadowMapTexture] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 13 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedaeadpnkmdaeikkmhegolgofbngcfleddabaaaaaadiaeaaaaaeaaaaaa
daaaaaaakeabaaaajeadaaaaaeaeaaaaebgpgodjgmabaaaagmabaaaaaaacpppp
deabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaahaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaadlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaaaaaoelaabaioekaacaaaaadaaaaccia
aaaaaaiaaaaaaaiaafaaaaadaaaacoiaabaabliaaaaaffiaafaaaaadabaaciia
abaappiaacaaaakaafaaaaadabaachiaabaaoeiaabaappiaakaaaaadacaachia
aaaabliaabaaoeiaafaaaaadaaaachiaaaaaaaiaabaaoeiaalaaaaadabaachia
acaaoeiaaaaaoeiaabaaaaacaaaaahiaaaaaoekaaeaaaaaeaaaachiaaaaaoeia
abaaoeiaabaaoekaabaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcoiabaaaaeaaaaaaahkaaaaaafjaaaaaeegiocaaaaaaaaaaa
ajaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahccaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadiaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagajbaaa
abaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaeb
diaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaapgapbaaaabaaaaaaddaaaaah
ocaabaaaaaaaaaaafgaobaaaaaaaaaaaagajbaaaabaaaaaadiaaaaahhcaabaaa
abaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaa
aaaaaaaaahaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaiaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES3"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 9 to 17
//   d3d9 - ALU: 9 to 17
//   d3d11 - ALU: 3 to 7, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 3 to 7, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 13 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 14 [unity_Scale]
Matrix 9 [_LightMatrix0]
"!!ARBvp1.0
# 16 ALU
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
ADD result.texcoord[1].xyz, -R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"vs_2_0
; 16 ALU
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT2.z, r0, c10
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
add oT1.xyz, -r0, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjbagmlnhfgpadjpojednogacopbafeniabaaaaaaciafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
keadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_6)).w) * 2.0));
  c_7.w = 0.0;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, vec2(tmpvar_6)).w) * 2.0));
  c_7.w = 0.0;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaacaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v2.z, r0, c10
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaamaaaaoeabaaaaaa add v1.xyz, r0.xyzz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednjlhgbaeclipldcmndpdegegeebfmjbaabaaaaaagaahaaaaaeaaaaaa
daaaaaaageacaaaabaagaaaaniagaaaaebgpgodjcmacaaaacmacaaaaaaacpopp
miabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaalaaoekaaeaaaaaeaaaaahiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappjaaaaaoeiaacaaaaadabaaahoaaaaaoeibafaaoekaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeacaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefckeadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 384
struct Input {
    highp vec3 worldPos;
};
#line 397
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 389
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 405
#line 76
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return (_WorldSpaceLightPos0.xyz - worldPos);
}
#line 405
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 409
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 414
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 384
struct Input {
    highp vec3 worldPos;
};
#line 397
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 389
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 405
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 392
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 394
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 416
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 418
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 422
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 426
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingLambert( o, lightDir, (texture( _LightTexture0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * 1.0));
    c.w = 0.0;
    #line 430
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 10 [unity_Scale]
"!!ARBvp1.0
# 9 ALU
PARAM c[11] = { program.local[0],
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[10].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
MOV result.texcoord[1].xyz, c[9];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 9 [unity_Scale]
"vs_2_0
; 9 ALU
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c9.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
mov oT1.xyz, c8
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 10 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedadephbcibkjjklcfhahcomkdcngingipabaaaaaacaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcleabaaaaeaaaabaagnaaaaaafjaaaaaeegiocaaaaaaaaaaa
abaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaa
egbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaa
egiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaak
hccabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaa
aaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaaaaaaaaaaaaaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * 2.0));
  c_5.w = 0.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * 2.0));
  c_5.w = 0.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 9 [unity_Scale]
"agal_vs
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaaajaaaappabaaaaaa mul r0.xyz, a1, c9.w
bcaaaaaaaaaaaeaeaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r0.xyzz, c6
bcaaaaaaaaaaacaeaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r0.xyzz, c5
bcaaaaaaaaaaabaeaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r0.xyzz, c4
aaaaaaaaabaaahaeaiaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, c8
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityLighting" 0
BindCB "UnityPerDraw" 1
// 10 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedgcjeojicaegnnejmkebiefkblbgnfgnkabaaaaaageaeaaaaaeaaaaaa
daaaaaaahaabaaaacmadaaaapeadaaaaebgpgodjdiabaaaadiabaaaaaaacpopp
oaaaaaaafiaaaaaaaeaaceaaaaaafeaaaaaafeaaaaaaceaaabaafeaaaaaaaaaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaabaaamaaadaaagaaaaaaaaaa
abaabeaaabaaajaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaaciaacaaapjaafaaaaadaaaaahiaacaaoejaajaappkaafaaaaad
abaaahiaaaaaffiaahaaoekaaeaaaaaeaaaaaliaagaakekaaaaaaaiaabaakeia
aeaaaaaeaaaaahoaaiaaoekaaaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffja
adaaoekaaeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aeaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaahoaabaaoekappppaaaafdeieefcleabaaaaeaaaabaagnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaabaaaaaafjaaaaaeegiocaaaabaaaaaabfaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaabaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaabaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaabaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaabaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
aaaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 76
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return _WorldSpaceLightPos0.xyz;
}
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 406
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    #line 410
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 412
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 414
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 418
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 422
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingLambert( o, lightDir, 1.0);
    c.w = 0.0;
    #line 426
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 13 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 14 [unity_Scale]
Matrix 9 [_LightMatrix0]
"!!ARBvp1.0
# 17 ALU
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[2].w, R0, c[12];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
ADD result.texcoord[1].xyz, -R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"vs_2_0
; 17 ALU
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT2.w, r0, c11
dp4 oT2.z, r0, c10
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
add oT1.xyz, -r0, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedbfollafedkcjbkpbkblmkfincjbaobggabaaaaaaciafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
keadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
pccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaaegiocaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pccabaaaadaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaobaaa
abaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp float atten_8;
  atten_8 = ((float((xlv_TEXCOORD2.z > 0.0)) * texture2D (_LightTexture0, P_6).w) * texture2D (_LightTextureB0, vec2(tmpvar_7)).w);
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * atten_8) * 2.0));
  c_9.w = 0.0;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = dot (xlv_TEXCOORD2.xyz, xlv_TEXCOORD2.xyz);
  lowp float atten_8;
  atten_8 = ((float((xlv_TEXCOORD2.z > 0.0)) * texture2D (_LightTexture0, P_6).w) * texture2D (_LightTextureB0, vec2(tmpvar_7)).w);
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * atten_8) * 2.0));
  c_9.w = 0.0;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaacaaaiaeaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 v2.w, r0, c11
bdaaaaaaacaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v2.z, r0, c10
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaamaaaaoeabaaaaaa add v1.xyz, r0.xyzz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednminbgfhgcnebocabjdokepflbaalnelabaaaaaagaahaaaaaeaaaaaa
daaaaaaageacaaaabaagaaaaniagaaaaebgpgodjcmacaaaacmacaaaaaaacpopp
miabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaalaaoekaaeaaaaaeaaaaahiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappjaaaaaoeiaacaaaaadabaaahoaaaaaoeibafaaoekaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaapiaaaaaffiaacaaoekaaeaaaaaeabaaapia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeabaaapiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeacaaapoaaeaaoekaaaaappiaabaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefckeadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiocaaaaaaaaaaaaeaaaaaadcaaaaakpcaabaaaabaaaaaa
egiocaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadcaaaaak
pcaabaaaabaaaaaaegiocaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaobaaa
abaaaaaadcaaaaakpccabaaaadaaaaaaegiocaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 393
struct Input {
    highp vec3 worldPos;
};
#line 406
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
#line 389
#line 398
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 414
#line 76
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return (_WorldSpaceLightPos0.xyz - worldPos);
}
#line 414
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 418
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex));
    #line 423
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec4(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 393
struct Input {
    highp vec3 worldPos;
};
#line 406
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec4 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
#line 389
#line 398
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 414
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 389
lowp float UnitySpotAttenuate( in highp vec3 LightCoord ) {
    return texture( _LightTextureB0, vec2( dot( LightCoord, LightCoord))).w;
}
#line 385
lowp float UnitySpotCookie( in highp vec4 LightCoord ) {
    return texture( _LightTexture0, ((LightCoord.xy / LightCoord.w) + 0.5)).w;
}
#line 401
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 403
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 425
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 427
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 431
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 435
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingLambert( o, lightDir, (((float((IN._LightCoord.z > 0.0)) * UnitySpotCookie( IN._LightCoord)) * UnitySpotAttenuate( IN._LightCoord.xyz)) * 1.0));
    c.w = 0.0;
    #line 439
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 13 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 14 [unity_Scale]
Matrix 9 [_LightMatrix0]
"!!ARBvp1.0
# 16 ALU
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[2].z, R0, c[11];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
ADD result.texcoord[1].xyz, -R0, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 16 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"vs_2_0
; 16 ALU
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT2.z, r0, c10
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
add oT1.xyz, -r0, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedjbagmlnhfgpadjpojednogacopbafeniabaaaaaaciafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
keadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
hccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaaacaaaaaaegacbaia
ebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaaegiccaaaaaaaaaaa
adaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaa
egiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, xlv_TEXCOORD2).w)) * 2.0));
  c_7.w = 0.0;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD1);
  lightDir_2 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = dot (xlv_TEXCOORD2, xlv_TEXCOORD2);
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * (texture2D (_LightTextureB0, vec2(tmpvar_6)).w * textureCube (_LightTexture0, xlv_TEXCOORD2).w)) * 2.0));
  c_7.w = 0.0;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaacaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v2.z, r0, c10
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaabaaahaeaaaaaakeacaaaaaaamaaaaoeabaaaaaa add v1.xyz, r0.xyzz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 22 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednjlhgbaeclipldcmndpdegegeebfmjbaabaaaaaagaahaaaaaeaaaaaa
daaaaaaageacaaaabaagaaaaniagaaaaebgpgodjcmacaaaacmacaaaaaaacpopp
miabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaahiaaaaaffjaalaaoekaaeaaaaaeaaaaahiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaahiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaahia
anaaoekaaaaappjaaaaaoeiaacaaaaadabaaahoaaaaaoeibafaaoekaafaaaaad
aaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaanaaoeka
aaaappjaaaaaoeiaafaaaaadabaaahiaaaaaffiaacaaoekaaeaaaaaeabaaahia
abaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaahiaadaaoekaaaaakkiaabaaoeia
aeaaaaaeacaaahoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapiaaaaaffja
ahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
aiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
ppppaaaafdeieefckeadaaaaeaaaabaaojaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagfaaaaadhccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaa
abaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgbkbaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
acaaaaaaapaaaaaapgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhccabaaa
acaaaaaaegacbaiaebaaaaaaaaaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
apaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaabaaaaaa
fgafbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadcaaaaakhcaabaaaabaaaaaa
egiccaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadcaaaaak
hcaabaaaaaaaaaaaegiccaaaaaaaaaaaafaaaaaakgakbaaaaaaaaaaaegacbaaa
abaaaaaadcaaaaakhccabaaaadaaaaaaegiccaaaaaaaaaaaagaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
adaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 385
struct Input {
    highp vec3 worldPos;
};
#line 398
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
#line 390
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 406
#line 76
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return (_WorldSpaceLightPos0.xyz - worldPos);
}
#line 406
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 410
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xyz;
    #line 415
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec3(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 385
struct Input {
    highp vec3 worldPos;
};
#line 398
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec3 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform samplerCube _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 384
uniform sampler2D _LightTextureB0;
#line 390
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 406
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 393
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 395
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 417
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 419
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 423
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 427
    surf( surfIN, o);
    lowp vec3 lightDir = normalize(IN.lightDir);
    lowp vec4 c = LightingLambert( o, lightDir, ((texture( _LightTextureB0, vec2( dot( IN._LightCoord, IN._LightCoord))).w * texture( _LightTexture0, IN._LightCoord).w) * 1.0));
    c.w = 0.0;
    #line 431
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec3(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 13 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 14 [unity_Scale]
Matrix 9 [_LightMatrix0]
"!!ARBvp1.0
# 15 ALU
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[14].w;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[2].y, R0, c[10];
DP4 result.texcoord[2].x, R0, c[9];
DP3 result.texcoord[0].z, R1, c[7];
DP3 result.texcoord[0].y, R1, c[6];
DP3 result.texcoord[0].x, R1, c[5];
MOV result.texcoord[1].xyz, c[13];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 15 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"vs_2_0
; 15 ALU
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c13.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT2.y, r0, c9
dp4 oT2.x, r0, c8
dp3 oT0.z, r1, c6
dp3 oT0.y, r1, c5
dp3 oT0.x, r1, c4
mov oT1.xyz, c12
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedlogopdpgoklkniijmiokhfgkpbfgncjaabaaaaaaieaeaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
aaadaaaaeaaaabaamaaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaabaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadhccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaa
acaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaa
acaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaa
agaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaa
acaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaa
acaaaaaaegiccaaaabaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaamaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaa
agaabaaaaaaaaaaaegaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaa
aaaaaaaaafaaaaaakgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaa
adaaaaaaegiacaaaaaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaa
doaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD2).w) * 2.0));
  c_5.w = 0.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform lowp vec4 _WorldSpaceLightPos0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 _Color;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  lightDir_2 = xlv_TEXCOORD1;
  lowp vec4 c_5;
  c_5.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD0, lightDir_2)) * texture2D (_LightTexture0, xlv_TEXCOORD2).w) * 2.0));
  c_5.w = 0.0;
  c_1.xyz = c_5.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 12 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 13 [unity_Scale]
Matrix 8 [_LightMatrix0]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaanaaaappabaaaaaa mul r1.xyz, a1, c13.w
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaacaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v2.y, r0, c9
bdaaaaaaacaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v2.x, r0, c8
bcaaaaaaaaaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v0.z, r1.xyzz, c6
bcaaaaaaaaaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v0.y, r1.xyzz, c5
bcaaaaaaaaaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v0.x, r1.xyzz, c4
aaaaaaaaabaaahaeamaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.xyz, c12
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaaaaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v0.w, c0
aaaaaaaaabaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v1.w, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "$Globals" 160 // 112 used size, 7 vars
Matrix 48 [_LightMatrix0] 4
ConstBuffer "UnityLighting" 400 // 16 used size, 16 vars
Vector 0 [_WorldSpaceLightPos0] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "$Globals" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 18 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedhikablenajlieepfgediebkkpnnbmihdabaaaaaagmagaaaaaeaaaaaa
daaaaaaabeacaaaabmafaaaaoeafaaaaebgpgodjnmabaaaanmabaaaaaaacpopp
hiabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaadaa
aeaaabaaaaaaaaaaabaaaaaaabaaafaaaaaaaaaaacaaaaaaaeaaagaaaaaaaaaa
acaaamaaaeaaakaaaaaaaaaaacaabeaaabaaaoaaaaaaaaaaaaaaaaaaaaacpopp
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaahia
acaaoejaaoaappkaafaaaaadabaaahiaaaaaffiaalaaoekaaeaaaaaeaaaaalia
akaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaamaaoekaaaaakkiaaaaapeia
afaaaaadaaaaapiaaaaaffjaalaaoekaaeaaaaaeaaaaapiaakaaoekaaaaaaaja
aaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapia
anaaoekaaaaappjaaaaaoeiaafaaaaadabaaadiaaaaaffiaacaaoekaaeaaaaae
aaaaadiaabaaoekaaaaaaaiaabaaoeiaaeaaaaaeaaaaadiaadaaoekaaaaakkia
aaaaoeiaaeaaaaaeacaaadoaaeaaoekaaaaappiaaaaaoeiaafaaaaadaaaaapia
aaaaffjaahaaoekaaeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaaiaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappja
aaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacabaaahoaafaaoekappppaaaafdeieefcaaadaaaaeaaaabaa
maaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaa
abaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
hccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaacaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaghccabaaaacaaaaaaegiccaaa
abaaaaaaaaaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaanaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaamaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaapaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaidcaabaaaabaaaaaafgafbaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaa
dcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaadaaaaaaagaabaaaaaaaaaaa
egaabaaaabaaaaaadcaaaaakdcaabaaaaaaaaaaaegiacaaaaaaaaaaaafaaaaaa
kgakbaaaaaaaaaaaegaabaaaaaaaaaaadcaaaaakdccabaaaadaaaaaaegiacaaa
aaaaaaaaagaaaaaapgapbaaaaaaaaaaaegaabaaaaaaaaaaadoaaaaabejfdeheo
maaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdej
feejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepem
epfcaaklepfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahaiaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaiaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 384
struct Input {
    highp vec3 worldPos;
};
#line 397
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 389
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 405
#line 76
highp vec3 WorldSpaceLightDir( in highp vec4 v ) {
    highp vec3 worldPos = (_Object2World * v).xyz;
    return _WorldSpaceLightPos0.xyz;
}
#line 405
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 409
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    highp vec3 lightDir = WorldSpaceLightDir( v.vertex);
    o.lightDir = lightDir;
    o._LightCoord = (_LightMatrix0 * (_Object2World * v.vertex)).xy;
    #line 414
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
out mediump vec3 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
    xlv_TEXCOORD1 = vec3(xl_retval.lightDir);
    xlv_TEXCOORD2 = vec2(xl_retval._LightCoord);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 384
struct Input {
    highp vec3 worldPos;
};
#line 397
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
    mediump vec3 lightDir;
    highp vec2 _LightCoord;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform lowp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
uniform sampler2D _LightTexture0;
uniform highp mat4 _LightMatrix0;
#line 389
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 405
#line 329
lowp vec4 LightingLambert( in SurfaceOutput s, in lowp vec3 lightDir, in lowp float atten ) {
    lowp float diff = max( 0.0, dot( s.Normal, lightDir));
    lowp vec4 c;
    #line 333
    c.xyz = ((s.Albedo * _LightColor0.xyz) * ((diff * atten) * 2.0));
    c.w = s.Alpha;
    return c;
}
#line 392
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 394
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 416
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 418
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 422
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 426
    surf( surfIN, o);
    lowp vec3 lightDir = IN.lightDir;
    lowp vec4 c = LightingLambert( o, lightDir, (texture( _LightTexture0, IN._LightCoord).w * 1.0));
    c.w = 0.0;
    #line 430
    return c;
}
in lowp vec3 xlv_TEXCOORD0;
in mediump vec3 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xlt_IN.lightDir = vec3(xlv_TEXCOORD1);
    xlt_IN._LightCoord = vec2(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 8 to 19, TEX: 0 to 2
//   d3d9 - ALU: 9 to 19, TEX: 1 to 2
//   d3d11 - ALU: 5 to 15, TEX: 0 to 2, FLOW: 1 to 1
//   d3d11_9x - ALU: 5 to 15, TEX: 0 to 2, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MOV result.color.w, c[2].x;
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, fragment.texcoord[1];
MOV R0.xyz, c[0];
DP3 R1.x, fragment.texcoord[0], R1;
MAX R1.x, R1, c[2];
MUL R0.xyz, R0, c[1];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
END
# 13 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
"ps_2_0
; 14 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dp3 r0.x, t2, t2
mov r0.xy, r0.x
mov_pp r1.xyz, c1
mul_pp r1.xyz, c0, r1
mov_pp r0.w, c2.x
texld r2, r0, s0
dp3_pp r0.x, t1, t1
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t1
dp3_pp r0.x, t0, r0
max_pp r0.x, r0, c2
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c2.y
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 12 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedcaigjedfcpdpmolmeehjfcjkcenlclknabaaaaaajeacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaadiaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaabaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c1
adaaaaaaabaaahacaaaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c0, r1.xyzz
ciaaaaaaaaaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r0, r0.xyyy, s0 <2d wrap linear point>
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, v1, v1
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r0.xyz, r0.x, v1
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v0, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 12 instructions, 2 temp regs, 0 temp arrays:
// ALU 9 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedgihbmjjncommihgidbgabmhcldifcldaabaaaaaapaadaaaaaeaaaaaa
daaaaaaaiiabaaaadeadaaaalmadaaaaebgpgodjfaabaaaafaabaaaaaaacpppp
baabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaachla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaacaaaaaaja
aaaiapkaaiaaaaadaaaaaiiaacaaoelaacaaoelaabaaaaacaaaaadiaaaaappia
ecaaaaadaaaacpiaaaaaoeiaaaaioekaceaaaaacabaachiaabaaoelaaiaaaaad
aaaacciaaaaaoelaabaaoeiaafaaaaadaaaacbiaaaaaaaiaaaaaffiafiaaaaae
aaaacbiaaaaaffiaaaaaaaiaacaaaakaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
abaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablkaafaaaaad
aaaachiaaaaaaaiaaaaabliaabaaaaacaaaaaiiaacaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefckeabaaaaeaaaaaaagjaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
hcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaa
egbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
baaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaaj
pcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
apaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaaagaabaaaabaaaaaadiaaaaaj
ocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaa
diaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 0 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
MOV R1.xyz, fragment.texcoord[1];
MOV R0.xyz, c[0];
DP3 R0.w, fragment.texcoord[0], R1;
MUL R0.xyz, R0, c[1];
MAX R0.w, R0, c[2].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
MOV result.color.w, c[2].x;
END
# 8 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
"ps_2_0
; 9 ALU
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
mov_pp r0.xyz, t1
dp3_pp r0.x, t0, r0
mov_pp r1.xyz, c1
mul_pp r1.xyz, c0, r1
max_pp r0.x, r0, c2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c2.y
mov_pp r0.w, c2.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 96 // 64 used size, 6 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
BindCB "$Globals" 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjacpffdbceegoejdkoonabgeddcminkeabaaaaaamiabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaaaaaaaeaaaaaaadmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaagcbaaaadhcbabaaaabaaaaaagcbaaaad
hcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
aaaaaaaaaaaaahacabaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v1
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v0, r0.xyzz
aaaaaaaaabaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c1
adaaaaaaabaaahacaaaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c0, r1.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL" }
ConstBuffer "$Globals" 96 // 64 used size, 6 vars
Vector 16 [_LightColor0] 4
Vector 48 [_Color] 4
BindCB "$Globals" 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedpoclgiommjkpkegnbjcjbdeppddmelkhabaaaaaamiacaaaaaeaaaaaa
daaaaaaacmabaaaaceacaaaajeacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
liaaaaaadmaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaaaaadmaaaaaaabaa
abaaaaaaaaaaaaaaaaaaadaaabaaabaaaaaaaaaaaaacppppfbaaaaafacaaapka
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaachlabpaaaaac
aaaaaaiaabaachlaabaaaaacaaaaahiaaaaaoelaaiaaaaadaaaacbiaaaaaoeia
abaaoelaalaaaaadabaaciiaaaaaaaiaacaaaakaacaaaaadaaaacbiaabaappia
abaappiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablka
afaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaaiiaacaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcpaaaaaaaeaaaaaaadmaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaaaaaaaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaakaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaa
abaaaaaaagijcaaaaaaaaaaaadaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaa
aaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
ahahaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
DP3 R0.z, fragment.texcoord[2], fragment.texcoord[2];
RCP R0.x, fragment.texcoord[2].w;
MAD R0.xy, fragment.texcoord[2], R0.x, c[2].y;
MOV result.color.w, c[2].x;
TEX R0.w, R0, texture[0], 2D;
TEX R1.w, R0.z, texture[1], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R0.x;
MUL R1.xyz, R1.x, fragment.texcoord[1];
DP3 R1.x, fragment.texcoord[0], R1;
SLT R1.y, c[2].x, fragment.texcoord[2].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MOV R0.xyz, c[0];
MAX R0.w, R1.x, c[2].x;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].z;
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"ps_2_0
; 19 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0.xyz
dcl t1.xyz
dcl t2
rcp r1.x, t2.w
mad r2.xy, t2, r1.x, c2.x
dp3 r0.x, t2, t2
mov r1.xy, r0.x
texld r0, r2, s0
texld r2, r1, s1
cmp r0.x, -t2.z, c2.y, c2.z
mul_pp r0.x, r0, r0.w
mul_pp r0.x, r0, r2
dp3_pp r1.x, t1, t1
rsq_pp r1.x, r1.x
mul_pp r1.xyz, r1.x, t1
mov_pp r2.xyz, c1
dp3_pp r1.x, t0, r1
max_pp r1.x, r1, c2.y
mul_pp r2.xyz, c0, r2
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c2.w
mov_pp r0.w, c2.y
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
// 19 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 1 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedfbhjipfghblgdcepfmlcfnjhjiaenfljabaaaaaaiiadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjiacaaaaeaaaaaaakgaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaabaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
SetTexture 1 [_LightTextureB0] 2D
"agal_ps
c2 0.5 0.0 1.0 2.0
[bc]
afaaaaaaabaaabacacaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v2.w
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
adaaaaaaabaaadacacaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v2, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaacaaaaaaabaaaaaa add r1.xy, r1.xyyy, c2.x
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaacaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.xyz, c1
adaaaaaaacaaahacaaaaaaoeabaaaaaaacaaaakeacaaaaaa mul r2.xyz, c0, r2.xyzz
ciaaaaaaabaaapacabaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r1.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r0, r0.xyyy, s1 <2d wrap linear point>
bfaaaaaaacaaaiacacaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r2.w, v2.z
ckaaaaaaaaaaabacacaaaappacaaaaaaacaaaaffabaaaaaa slt r0.x, r2.w, c2.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaappacaaaaaa mul r0.x, r0.x, r1.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
bcaaaaaaabaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r1.x, v1, v1
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaabaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r1.xyz, r1.x, v1
bcaaaaaaabaaabacaaaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v0, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaffabaaaaaa max r1.x, r1.x, c2.y
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaappabaaaaaa mul r0.xyz, r0.xyzz, c2.w
aaaaaaaaaaaaaiacacaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "SPOT" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
SetTexture 1 [_LightTextureB0] 2D 1
// 19 instructions, 2 temp regs, 0 temp arrays:
// ALU 14 float, 0 int, 1 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedlcadpkinkghnpnamehhjfbcekbdcgkmaabaaaaaaeeafaaaaaeaaaaaa
daaaaaaaoiabaaaaiiaeaaaabaafaaaaebgpgodjlaabaaaalaabaaaaaaacpppp
gmabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
aeaaaaaeaaaaadiaacaaoelaaaaappiaacaaaakaaiaaaaadabaaaiiaacaaoela
acaaoelaabaaaaacabaaadiaabaappiaecaaaaadaaaacpiaaaaaoeiaaaaioeka
ecaaaaadabaacpiaabaaoeiaabaioekaafaaaaadaaaacbiaaaaappiaabaaaaia
fiaaaaaeaaaacbiaacaakklbacaaffkaaaaaaaiaceaaaaacabaachiaabaaoela
aiaaaaadaaaacciaaaaaoelaabaaoeiaalaaaaadabaacbiaaaaaffiaacaaffka
afaaaaadaaaacbiaaaaaaaiaabaaaaiaacaaaaadaaaacbiaaaaaaaiaaaaaaaia
abaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablkaafaaaaad
aaaachiaaaaaaaiaaaaabliaabaaaaacaaaaaiiaacaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcjiacaaaaeaaaaaaakgaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadpcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaaaaaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaaaaackbabaaaadaaaaaaabaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdiaaaaahbcaabaaa
aaaaaaaadkaabaaaaaaaaaaaakaabaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaa
egbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaakaabaaaabaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaa
acaaaaaaegbcbaaaacaaaaaaeeaaaaafccaabaaaaaaaaaaabkaabaaaaaaaaaaa
diaaaaahocaabaaaaaaaaaaafgafbaaaaaaaaaaaagbjbaaaacaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaabaaaaaajgahbaaaaaaaaaaadeaaaaahccaabaaa
aaaaaaaabkaabaaaaaaaaaaaabeaaaaaaaaaaaaaapaaaaahbcaabaaaaaaaaaaa
fgafbaaaaaaaaaaaagaabaaaaaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaa
aaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaa
agaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 15 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R1.w, fragment.texcoord[2], texture[1], CUBE;
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
MOV result.color.w, c[2].x;
TEX R0.w, R0.x, texture[0], 2D;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R1.x, R0.x;
MUL R1.xyz, R1.x, fragment.texcoord[1];
DP3 R1.x, fragment.texcoord[0], R1;
MUL R1.y, R0.w, R1.w;
MOV R0.xyz, c[0];
MAX R0.w, R1.x, c[2].x;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, R1.y;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
END
# 15 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"ps_2_0
; 15 ALU, 2 TEX
dcl_2d s0
dcl_cube s1
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xyz
dp3 r0.x, t2, t2
mov r0.xy, r0.x
texld r2, r0, s0
texld r0, t2, s1
dp3_pp r0.x, t1, t1
rsq_pp r1.x, r0.x
mul_pp r1.xyz, r1.x, t1
dp3_pp r1.x, t0, r1
mul r0.x, r2, r0.w
mov_pp r2.xyz, c1
max_pp r1.x, r1, c2
mul_pp r2.xyz, c0, r2
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c2.y
mov_pp r0.w, c2.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
// 14 instructions, 3 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjllnilbpelgkhjfhmcblecfdlpfcebofabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaahahaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaadhcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaabaaaaaahbcaabaaa
aaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaaeeaaaaafbcaabaaaaaaaaaaa
akaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegbcbaaa
acaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
deaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaabaaaaaah
ccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaaadaaaaaaefaaaaajpcaabaaa
abaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
diaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaadkaabaaaacaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaaaaaaaaaadiaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTextureB0] 2D
SetTexture 1 [_LightTexture0] CUBE
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaacaaaaoeaeaaaaaa dp3 r0.x, v2, v2
aaaaaaaaaaaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r0.xy, r0.x
aaaaaaaaacaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r2.xyz, c1
adaaaaaaacaaahacaaaaaaoeabaaaaaaacaaaakeacaaaaaa mul r2.xyz, c0, r2.xyzz
ciaaaaaaabaaapacaaaaaafeacaaaaaaaaaaaaaaafaababb tex r1, r0.xyyy, s0 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaabaaaaaaafbababb tex r0, v2, s1 <cube wrap linear point>
bcaaaaaaaaaaabacabaaaaoeaeaaaaaaabaaaaoeaeaaaaaa dp3 r0.x, v1, v1
akaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r0.x
adaaaaaaaaaaabacabaaaappacaaaaaaaaaaaappacaaaaaa mul r0.x, r1.w, r0.w
adaaaaaaabaaahacabaaaaaaacaaaaaaabaaaaoeaeaaaaaa mul r1.xyz, r1.x, v1
bcaaaaaaabaaabacaaaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v0, r1.xyzz
ahaaaaaaabaaabacabaaaaaaacaaaaaaacaaaaoeabaaaaaa max r1.x, r1.x, c2
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "POINT_COOKIE" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTextureB0] 2D 1
SetTexture 1 [_LightTexture0] CUBE 0
// 14 instructions, 3 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedanciejpbffnjgkcmifpppfcjcdfmfkapabaaaaaahiaeaaaaaeaaaaaa
daaaaaaaleabaaaalmadaaaaeeaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
diabaaaaeeaaaaaaacaacmaaaaaaeeaaaaaaeeaaacaaceaaaaaaeeaaabaaaaaa
aaababaaaaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacpppp
fbaaaaafacaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlabpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaahlabpaaaaac
aaaaaajiaaaiapkabpaaaaacaaaaaajaabaiapkaaiaaaaadaaaaaiiaacaaoela
acaaoelaabaaaaacaaaaadiaaaaappiaecaaaaadaaaaapiaaaaaoeiaabaioeka
ecaaaaadabaaapiaacaaoelaaaaioekaafaaaaadaaaacbiaaaaaaaiaabaappia
ceaaaaacabaachiaabaaoelaaiaaaaadaaaacciaaaaaoelaabaaoeiaalaaaaad
abaacbiaaaaaffiaacaaaakaafaaaaadaaaacbiaaaaaaaiaabaaaaiaacaaaaad
aaaacbiaaaaaaaiaaaaaaaiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoia
abaabliaaaaablkaafaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaaiia
acaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaaacaaaaeaaaaaaa
iaaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafidaaaae
aahabaaaabaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagcbaaaadhcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaaacaaaaaaegbcbaaaacaaaaaa
eeaaaaafbcaabaaaaaaaaaaaakaabaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegbcbaaaacaaaaaabaaaaaahbcaabaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaaaaaaaaadeaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaabaaaaaahccaabaaaaaaaaaaaegbcbaaaadaaaaaaegbcbaaa
adaaaaaaefaaaaajpcaabaaaabaaaaaafgafbaaaaaaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbcbaaaadaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaadiaaaaahccaabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaacaaaaaaapaaaaahbcaabaaaaaaaaaaaagaabaaaaaaaaaaafgafbaaa
aaaaaaaadiaaaaajocaabaaaaaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaa
aaaaaaaaahaaaaaadiaaaaahhccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahahaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[2], texture[0], 2D;
MOV R1.xyz, fragment.texcoord[1];
MOV R0.xyz, c[0];
DP3 R1.x, fragment.texcoord[0], R1;
MAX R1.x, R1, c[2];
MUL R0.xyz, R0, c[1];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[2].y;
MOV result.color.w, c[2].x;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
"ps_2_0
; 10 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2.xy
texld r0, t2, s0
mov_pp r0.xyz, t1
dp3_pp r0.x, t0, r0
mov_pp r1.xyz, c1
max_pp r0.x, r0, c2
mul_pp r0.x, r0, r0.w
mul_pp r1.xyz, c0, r1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c2.y
mov_pp r0.w, c2.x
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedddhgadjbgkjkhlfkehpobkknmkelmmkfabaaaaaacmacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdmabaaaaeaaaaaaaepaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabaaaaaah
bcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaapaaaaahbcaabaaa
aaaaaaaaagaabaaaaaaaaaaapgapbaaaabaaaaaadiaaaaajocaabaaaaaaaaaaa
agijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaahhccabaaa
aaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
SetTexture 0 [_LightTexture0] 2D
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaaaaaaaaaafaababb tex r0, v2, s0 <2d wrap linear point>
aaaaaaaaaaaaahacabaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v1
bcaaaaaaaaaaabacaaaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v0, r0.xyzz
aaaaaaaaabaaahacabaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, c1
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaappacaaaaaa mul r0.x, r0.x, r0.w
adaaaaaaabaaahacaaaaaaoeabaaaaaaabaaaakeacaaaaaa mul r1.xyz, c0, r1.xyzz
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
aaaaaaaaaaaaaiacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "d3d11_9x " {
Keywords { "DIRECTIONAL_COOKIE" }
ConstBuffer "$Globals" 160 // 128 used size, 7 vars
Vector 16 [_LightColor0] 4
Vector 112 [_Color] 4
BindCB "$Globals" 0
SetTexture 0 [_LightTexture0] 2D 0
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 5 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedjpcobkkjoebpbegicfndocfkccpofefoabaaaaaagmadaaaaaeaaaaaa
daaaaaaagmabaaaalaacaaaadiadaaaaebgpgodjdeabaaaadeabaaaaaaacpppp
peaaaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaabaaabaaaaaaaaaaaaaaaaaaahaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaachla
bpaaaaacaaaaaaiaabaachlabpaaaaacaaaaaaiaacaaadlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaacaaoelaaaaioekaabaaaaacaaaaahiaaaaaoela
aiaaaaadaaaacbiaaaaaoeiaabaaoelaafaaaaadaaaacciaaaaappiaaaaaaaia
fiaaaaaeaaaacbiaaaaaaaiaaaaaffiaacaaaakaacaaaaadaaaacbiaaaaaaaia
aaaaaaiaabaaaaacabaaahiaabaaoekaafaaaaadaaaacoiaabaabliaaaaablka
afaaaaadaaaachiaaaaaaaiaaaaabliaabaaaaacaaaaaiiaacaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcdmabaaaaeaaaaaaaepaaaaaafjaaaaae
egiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadhcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
baaaaaahbcaabaaaaaaaaaaaegbcbaaaabaaaaaaegbcbaaaacaaaaaadeaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaapaaaaah
bcaabaaaaaaaaaaaagaabaaaaaaaaaaapgapbaaaabaaaaaadiaaaaajocaabaaa
aaaaaaaaagijcaaaaaaaaaaaabaaaaaaagijcaaaaaaaaaaaahaaaaaadiaaaaah
hccabaaaaaaaaaaaagaabaaaaaaaaaaajgahbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 8 to 8
//   d3d9 - ALU: 8 to 8
//   d3d11 - ALU: 3 to 3, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 3 to 3, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Vector 9 [unity_Scale]
"!!ARBvp1.0
# 8 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Vector 8 [unity_Scale]
"vs_2_0
; 8 ALU
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c8.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "d3d11 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerDraw" 0
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefieceddgoflhcgfinoonoplgmdiabihpafgdafabaaaaaaneacaaaaadaaaaaa
cmaaaaaapeaaaaaaemabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheofaaaaaaaacaaaaaa
aiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaae
egiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadhccabaaaabaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
diaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaaaaaaaaabeaaaaaa
diaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaaaaaaaaaanaaaaaa
dcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaaamaaaaaaagaabaaaaaaaaaaa
egaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaaegiccaaaaaaaaaaaaoaaaaaa
kgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES


#ifdef VERTEX

varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerDraw" 0
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedfpmclfcoogjdlpcnlpgnljpcdonknacmabaaaaaaaaaeaaaaaeaaaaaa
daaaaaaafiabaaaaoaacaaaakiadaaaaebgpgodjcaabaaaacaabaaaaaaacpopp
neaaaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaamaaadaaafaaaaaaaaaaaaaabeaaabaaaiaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaahiaacaaoejaaiaappkaafaaaaadabaaahiaaaaaffiaagaaoeka
aeaaaaaeaaaaaliaafaakekaaaaaaaiaabaakeiaaeaaaaaeaaaaahoaahaaoeka
aaaakkiaaaaapeiaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadhccabaaaabaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaa
pgipcaaaaaaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaa
egiccaaaaaaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaaaaaaaaa
amaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhccabaaaabaaaaaa
egiccaaaaaaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadoaaaaab
ejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
kjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaalaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaa
faepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffiedepepfcee
aaedepemepfcaaklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 401
#line 401
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 405
    o.normal = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    return o;
}

out lowp vec3 xlv_TEXCOORD0;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec3(xl_retval.normal);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    lowp vec3 normal;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 401
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 408
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 410
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 414
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    o.Normal = IN.normal;
    #line 418
    surf( surfIN, o);
    lowp vec4 res;
    res.xyz = ((o.Normal * 0.5) + 0.5);
    res.w = o.Specular;
    #line 422
    return res;
}
in lowp vec3 xlv_TEXCOORD0;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.normal = vec3(xlv_TEXCOORD0);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 2 to 2, TEX: 0 to 0
//   d3d9 - ALU: 3 to 3
//   d3d11 - ALU: 0 to 0, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 0 to 0, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { }
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 2 ALU, 0 TEX
PARAM c[1] = { { 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[0], c[0].y, c[0].y;
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
"ps_2_0
; 3 ALU
def c0, 0.50000000, 0.00000000, 0, 0
dcl t0.xyz
mad_pp r0.xyz, t0, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { }
// 3 instructions, 0 temp regs, 0 temp arrays:
// ALU 0 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedhbdiiogganilkmhhpogjlnaalcliljppabaaaaaadeabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheaaaaaa
eaaaaaaabnaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaa
dcaaaaaphccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { }
// 3 instructions, 0 temp regs, 0 temp arrays:
// ALU 0 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedbcfagkfmhchaonghfjackccpkbjompokabaaaaaalmabaaaaaeaaaaaa
daaaaaaaleaaaaaadaabaaaaiiabaaaaebgpgodjhmaaaaaahmaaaaaaaaacpppp
fiaaaaaaceaaaaaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaaaceaaaaacpppp
fbaaaaafaaaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaachlaaeaaaaaeaaaachiaaaaaoelaaaaaaakaaaaaaakaabaaaaacaaaaciia
aaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcheaaaaaaeaaaaaaa
bnaaaaaagcbaaaadhcbabaaaabaaaaaagfaaaaadpccabaaaaaaaaaaadcaaaaap
hccabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheofaaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaahahaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { }
"!!GLES3"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 6
//   opengl - ALU: 10 to 27
//   d3d9 - ALU: 10 to 27
//   d3d11 - ALU: 4 to 15, TEX: 0 to 0, FLOW: 1 to 1
//   d3d11_9x - ALU: 4 to 15, TEX: 0 to 0, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 5 [_Object2World]
Vector 17 [unity_Scale]
"!!ARBvp1.0
# 27 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[1].xyz, R3, R2;
ADD result.texcoord[0].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
END
# 27 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 4 [_Object2World]
Vector 17 [unity_Scale]
"vs_2_0
; 27 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c18.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c18.x
mul r0.y, r0, c8.x
add oT1.xyz, r3, r2
mad oT0.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT0.zw, r1
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 26 instructions, 4 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfeagpkkppeeiblddbjjmbnmcbikkojddabaaaaaabmafaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefclaadaaaaeaaaabaaomaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaabaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaabaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaabaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
abaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
abaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
abaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD1);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = 0.0;
  c_2 = c_11;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD1);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = 0.0;
  c_2 = c_11;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 26 instructions, 4 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedhfogfnohfiajakjljliidnnbeogcbknaabaaaaaaiiahaaaaaeaaaaaa
daaaaaaajiacaaaafaagaaaabiahaaaaebgpgodjgaacaaaagaacaaaaaaacpopp
pmabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
abaaabaaaaaaaaaaabaabcaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaadaaanaaaaaaaaaaacaabeaaabaabaaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbbaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaabaaaakaafaaaaadabaaaiiaabaaaaiabbaaaakaafaaaaad
abaaafiaaaaapeiabbaaaakaacaaaaadaaaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaoejabaaappkaafaaaaadacaaahiaabaaffiaaoaaoekaaeaaaaae
abaaaliaanaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiaapaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabbaaffkaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaafaaoekaadaaoeia
ajaaaaadaeaaaciaagaaoekaadaaoeiaajaaaaadaeaaaeiaahaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffia
aeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeabaaahoaaiaaoeka
abaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefclaadaaaa
eaaaabaaomaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaabcaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaabdaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaabeaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaabfaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaabgaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaabhaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaabiaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 411
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 406
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.screen);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 411
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 337
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 341
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 413
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 415
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 419
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 423
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    light.xyz += IN.vlight;
    #line 427
    mediump vec4 c = LightingLambert_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.screen = vec4(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Vector 15 [unity_LightmapST]
"!!ARBvp1.0
# 19 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[0].zw, R0;
MUL result.texcoord[2].xyz, R1, c[14].w;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[2].w, -R0.x, R0.y;
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Vector 15 [unity_LightmapST]
"vs_2_0
; 19 ALU
def c16, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord1 v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
mul r1.y, r1, c12.x
mad oT0.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c16, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT0.zw, r0
mul oT2.xyz, r1, c14.w
mad oT1.xy, v1, c15, c15.zwzw
mul oT2.w, -r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedilfmbedkflkhaiopmphijhklkhjcdaidabaaaaaacmafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
kiadaaaaeaaaabaaokaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
agaaaaaaogikcaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = _Emission.xyz;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_12.w;
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lmFull_4 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  lmIndirect_3 = tmpvar_15;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_7 * light_6.xyz);
  c_16.xyz = tmpvar_17;
  c_16.w = 0.0;
  c_2 = c_16;
  c_2.xyz = (c_2.xyz + tmpvar_8);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = _Emission.xyz;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_12.w;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_LightmapInd, xlv_TEXCOORD1);
  highp float tmpvar_15;
  tmpvar_15 = ((sqrt(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((8.0 * tmpvar_13.w) * tmpvar_13.xyz);
  lmFull_4 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((8.0 * tmpvar_14.w) * tmpvar_14.xyz);
  lmIndirect_3 = tmpvar_17;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * light_6.xyz);
  c_18.xyz = tmpvar_19;
  c_18.w = 0.0;
  c_2 = c_18;
  c_2.xyz = (c_2.xyz + tmpvar_8);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedjifkdbnanelckdmcpmmmnheaoikjbmbdabaaaaaaieahaaaaaeaaaaaa
daaaaaaaieacaaaadeagaaaapmagaaaaebgpgodjemacaaaaemacaaaaaaacpopp
oiabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaagaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaabjaaabaaadaaaaaaaaaa
adaaaaaaaiaaaeaaaaaaaaaaadaaamaaaeaaamaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbaaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaeiaaeaaapjaafaaaaadaaaaapiaaaaaffjaafaaoeka
aeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiabaaaaakaafaaaaad
abaaafiaaaaapeiabaaaaakaacaaaaadaaaaadoaabaakkiaabaaomiaaeaaaaae
abaaadoaaeaaoejaabaaoekaabaaookaafaaaaadabaaahiaaaaaffjaanaaoeka
aeaaaaaeabaaahiaamaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahiaaoaaoeka
aaaakkjaabaaoeiaaeaaaaaeabaaahiaapaaoekaaaaappjaabaaoeiaacaaaaad
abaaahiaabaaoeiaadaaoekbafaaaaadacaaahoaabaaoeiaadaappkaafaaaaad
abaaabiaaaaaffjaajaakkkaaeaaaaaeabaaabiaaiaakkkaaaaaaajaabaaaaia
aeaaaaaeabaaabiaakaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaalaakkka
aaaappjaabaaaaiaabaaaaacabaaaiiaadaappkaacaaaaadabaaaciaabaappib
baaaffkaafaaaaadacaaaioaabaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeia
ppppaaaafdeieefckiadaaaaeaaaabaaokaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 403
uniform highp vec4 unity_LightmapST;
uniform sampler2D _LightBuffer;
#line 415
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 419
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 404
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 407
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    #line 411
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.screen);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
    xlv_TEXCOORD2 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 403
uniform highp vec4 unity_LightmapST;
uniform sampler2D _LightBuffer;
#line 415
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 419
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 337
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 341
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 419
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 423
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 427
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 431
    light = (-log2(light));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    #line 435
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    #line 439
    mediump vec4 c = LightingLambert_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.screen = vec4(xlv_TEXCOORD0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD1);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
"!!ARBvp1.0
# 10 ALU
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
"vs_2_0
; 10 ALU
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord1 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad oT0.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT0.zw, r0
mad oT1.xy, v1, c6, c6.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcjajajpjdleogfkgconcmoliaphohkajabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_9;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_11);
  light_3 = tmpvar_12;
  lowp vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_4 * tmpvar_12.xyz);
  c_13.xyz = tmpvar_14;
  c_13.w = 0.0;
  c_2 = c_13;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((8.0 * tmpvar_9.w) * tmpvar_9.xyz);
  lm_10 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = lm_10;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (-(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_12);
  light_3 = tmpvar_13;
  lowp vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_4 * tmpvar_13.xyz);
  c_14.xyz = tmpvar_15;
  c_14.w = 0.0;
  c_2 = c_14;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednjpjmfldkhdlkelpenjfpdmkaplnmeniabaaaaaajmaeaaaaaeaaaaaa
daaaaaaaiiabaaaageadaaaacmaeaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
aeabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaagaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaafaaaaadaaaaapia
aaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaia
ahaaaakaafaaaaadabaaafiaaaaapeiaahaaaakaacaaaaadaaaaadoaabaakkia
abaaomiaaeaaaaaeabaaadoaaeaaoejaabaaoekaabaaookaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaamoa
aaaaoeiappppaaaafdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
uniform highp vec4 unity_LightmapST;
#line 411
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 415
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 403
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 406
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.screen);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
uniform highp vec4 unity_LightmapST;
#line 411
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 415
uniform lowp vec4 unity_Ambient;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 316
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 320
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 325
    return lm;
}
#line 344
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 346
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 337
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 341
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 416
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 419
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 423
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    #line 427
    light = max( light, vec4( 0.001));
    light = (-log2(light));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    #line 431
    mediump vec4 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, false);
    light += lm;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    c.xyz += o.Emission;
    #line 435
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.screen = vec4(xlv_TEXCOORD0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [_ProjectionParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 5 [_Object2World]
Vector 17 [unity_Scale]
"!!ARBvp1.0
# 27 ALU
PARAM c[18] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..17] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[17].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[16];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[1].xyz, R3, R2;
ADD result.texcoord[0].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
END
# 27 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Matrix 4 [_Object2World]
Vector 17 [unity_Scale]
"vs_2_0
; 27 ALU
def c18, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
mul r1.xyz, v1, c17.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c18.y
dp4 r2.z, r0, c12
dp4 r2.y, r0, c11
dp4 r2.x, r0, c10
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c15
dp4 r3.y, r1, c14
dp4 r3.x, r1, c13
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c16
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c18.x
mul r0.y, r0, c8.x
add oT1.xyz, r3, r2
mad oT0.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT0.zw, r1
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 26 instructions, 4 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedfeagpkkppeeiblddbjjmbnmcbikkojddabaaaaaabmafaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefclaadaaaaeaaaabaaomaaaaaafjaaaaaeegiocaaaaaaaaaaa
agaaaaaafjaaaaaeegiocaaaabaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaa
bfaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaa
acaaaaaagiaaaaacaeaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaa
acaaaaaapgipcaaaacaaaaaabeaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaa
aaaaaaaaegiccaaaacaaaaaaanaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaa
acaaaaaaamaaaaaaagaabaaaaaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaacaaaaaaaoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaa
dgaaaaaficaabaaaaaaaaaaaabeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaa
egiocaaaabaaaaaabcaaaaaaegaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaa
egiocaaaabaaaaaabdaaaaaaegaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaa
egiocaaaabaaaaaabeaaaaaaegaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaa
jgacbaaaaaaaaaaaegakbaaaaaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaa
abaaaaaabfaaaaaaegaobaaaacaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaa
abaaaaaabgaaaaaaegaobaaaacaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaa
abaaaaaabhaaaaaaegaobaaaacaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaadaaaaaadiaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaa
bkaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaa
abaaaaaabiaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD1);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = 0.0;
  c_2 = c_11;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAr;
uniform highp vec4 _ProjectionParams;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  tmpvar_1 = tmpvar_8;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD1);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = 0.0;
  c_2 = c_11;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "color" Color
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityLighting" 400 // 400 used size, 16 vars
Vector 288 [unity_SHAr] 4
Vector 304 [unity_SHAg] 4
Vector 320 [unity_SHAb] 4
Vector 336 [unity_SHBr] 4
Vector 352 [unity_SHBg] 4
Vector 368 [unity_SHBb] 4
Vector 384 [unity_SHC] 4
ConstBuffer "UnityPerDraw" 336 // 336 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 192 [_Object2World] 4
Vector 320 [unity_Scale] 4
BindCB "UnityPerCamera" 0
BindCB "UnityLighting" 1
BindCB "UnityPerDraw" 2
// 26 instructions, 4 temp regs, 0 temp arrays:
// ALU 15 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedhfogfnohfiajakjljliidnnbeogcbknaabaaaaaaiiahaaaaaeaaaaaa
daaaaaaajiacaaaafaagaaaabiahaaaaebgpgodjgaacaaaagaacaaaaaaacpopp
pmabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaafaa
abaaabaaaaaaaaaaabaabcaaahaaacaaaaaaaaaaacaaaaaaaeaaajaaaaaaaaaa
acaaamaaadaaanaaaaaaaaaaacaabeaaabaabaaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbbaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaciaacaaapjaafaaaaadaaaaapiaaaaaffjaakaaoeka
aeaaaaaeaaaaapiaajaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaalaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaamaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaabaaaakaafaaaaadabaaaiiaabaaaaiabbaaaakaafaaaaad
abaaafiaaaaapeiabbaaaakaacaaaaadaaaaadoaabaakkiaabaaomiaafaaaaad
abaaahiaacaaoejabaaappkaafaaaaadacaaahiaabaaffiaaoaaoekaaeaaaaae
abaaaliaanaakekaabaaaaiaacaakeiaaeaaaaaeabaaahiaapaaoekaabaakkia
abaapeiaabaaaaacabaaaiiabbaaffkaajaaaaadacaaabiaacaaoekaabaaoeia
ajaaaaadacaaaciaadaaoekaabaaoeiaajaaaaadacaaaeiaaeaaoekaabaaoeia
afaaaaadadaaapiaabaacjiaabaakeiaajaaaaadaeaaabiaafaaoekaadaaoeia
ajaaaaadaeaaaciaagaaoekaadaaoeiaajaaaaadaeaaaeiaahaaoekaadaaoeia
acaaaaadacaaahiaacaaoeiaaeaaoeiaafaaaaadabaaaciaabaaffiaabaaffia
aeaaaaaeabaaabiaabaaaaiaabaaaaiaabaaffibaeaaaaaeabaaahoaaiaaoeka
abaaaaiaacaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefclaadaaaa
eaaaabaaomaaaaaafjaaaaaeegiocaaaaaaaaaaaagaaaaaafjaaaaaeegiocaaa
abaaaaaabjaaaaaafjaaaaaeegiocaaaacaaaaaabfaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadhcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaadhccabaaaacaaaaaagiaaaaacaeaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaaaaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadiaaaaaihcaabaaaaaaaaaaaegbcbaaaacaaaaaapgipcaaaacaaaaaa
beaaaaaadiaaaaaihcaabaaaabaaaaaafgafbaaaaaaaaaaaegiccaaaacaaaaaa
anaaaaaadcaaaaaklcaabaaaaaaaaaaaegiicaaaacaaaaaaamaaaaaaagaabaaa
aaaaaaaaegaibaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaacaaaaaa
aoaaaaaakgakbaaaaaaaaaaaegadbaaaaaaaaaaadgaaaaaficaabaaaaaaaaaaa
abeaaaaaaaaaiadpbbaaaaaibcaabaaaabaaaaaaegiocaaaabaaaaaabcaaaaaa
egaobaaaaaaaaaaabbaaaaaiccaabaaaabaaaaaaegiocaaaabaaaaaabdaaaaaa
egaobaaaaaaaaaaabbaaaaaiecaabaaaabaaaaaaegiocaaaabaaaaaabeaaaaaa
egaobaaaaaaaaaaadiaaaaahpcaabaaaacaaaaaajgacbaaaaaaaaaaaegakbaaa
aaaaaaaabbaaaaaibcaabaaaadaaaaaaegiocaaaabaaaaaabfaaaaaaegaobaaa
acaaaaaabbaaaaaiccaabaaaadaaaaaaegiocaaaabaaaaaabgaaaaaaegaobaaa
acaaaaaabbaaaaaiecaabaaaadaaaaaaegiocaaaabaaaaaabhaaaaaaegaobaaa
acaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
diaaaaahccaabaaaaaaaaaaabkaabaaaaaaaaaaabkaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaakaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaadcaaaaakhccabaaaacaaaaaaegiccaaaabaaaaaabiaaaaaaagaabaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaahahaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
laaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapaaaaaaljaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofe
aaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaahaiaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 411
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 136
mediump vec3 ShadeSH9( in mediump vec4 normal ) {
    mediump vec3 x1;
    mediump vec3 x2;
    mediump vec3 x3;
    x1.x = dot( unity_SHAr, normal);
    #line 140
    x1.y = dot( unity_SHAg, normal);
    x1.z = dot( unity_SHAb, normal);
    mediump vec4 vB = (normal.xyzz * normal.yzzx);
    x2.x = dot( unity_SHBr, vB);
    #line 144
    x2.y = dot( unity_SHBg, vB);
    x2.z = dot( unity_SHBb, vB);
    highp float vC = ((normal.x * normal.x) - (normal.y * normal.y));
    x3 = (unity_SHC.xyz * vC);
    #line 148
    return ((x1 + x2) + x3);
}
#line 402
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    o.pos = (glstate_matrix_mvp * v.vertex);
    #line 406
    o.screen = ComputeScreenPos( o.pos);
    highp vec3 worldN = (mat3( _Object2World) * (v.normal * unity_Scale.w));
    o.vlight = ShadeSH9( vec4( worldN, 1.0));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec3 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.screen);
    xlv_TEXCOORD1 = vec3(xl_retval.vlight);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec3 vlight;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
#line 411
uniform sampler2D _LightBuffer;
uniform lowp vec4 unity_Ambient;
#line 337
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 341
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 413
lowp vec4 frag_surf( in v2f_surf IN ) {
    #line 415
    Input surfIN;
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    #line 419
    o.Specular = 0.0;
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    #line 423
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    light.xyz += IN.vlight;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    #line 427
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec3 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.screen = vec4(xlv_TEXCOORD0);
    xlt_IN.vlight = vec3(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 9 [_Object2World]
Vector 15 [unity_LightmapST]
"!!ARBvp1.0
# 19 ALU
PARAM c[16] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..15] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[14].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[14];
MOV result.texcoord[0].zw, R0;
MUL result.texcoord[2].xyz, R1, c[14].w;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[15], c[15].zwzw;
MUL result.texcoord[2].w, -R0.x, R0.y;
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_ShadowFadeCenterAndType]
Matrix 8 [_Object2World]
Vector 15 [unity_LightmapST]
"vs_2_0
; 19 ALU
def c16, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord1 v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c16.x
mul r1.y, r1, c12.x
mad oT0.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c14.w
add r0.y, c16, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c14
mov oT0.zw, r0
mul oT2.xyz, r1, c14.w
mad oT1.xy, v1, c15, c15.zwzw
mul oT2.w, -r0.x, r0.y
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedilfmbedkflkhaiopmphijhklkhjcdaidabaaaaaacmafaaaaadaaaaaa
cmaaaaaapeaaaaaahmabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklfdeieefc
kiadaaaaeaaaabaaokaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaae
egiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaabkaaaaaafjaaaaae
egiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaa
aeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaadaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaabkaabaaaaaaaaaaa
akiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaaagahbaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaaabaaaaaamgaabaaa
abaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaaegiacaaaaaaaaaaa
agaaaaaaogikcaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaa
adaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaapgbpbaaaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegiccaia
ebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaaegacbaaaaaaaaaaa
pgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaa
aeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaaaaaaaaaaakaabaaa
aaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaaacaaaaaabjaaaaaa
abeaaaaaaaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaaaaaaaaaaakaabaia
ebaaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = _Emission.xyz;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_12.w;
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lmFull_4 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD1).xyz);
  lmIndirect_3 = tmpvar_15;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_7 * light_6.xyz);
  c_16.xyz = tmpvar_17;
  c_16.w = 0.0;
  c_2 = c_16;
  c_2.xyz = (c_2.xyz + tmpvar_8);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 _Object2World;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_3;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_LightmapInd;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = _Emission.xyz;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_12.w;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_LightmapInd, xlv_TEXCOORD1);
  highp float tmpvar_15;
  tmpvar_15 = ((sqrt(dot (xlv_TEXCOORD2, xlv_TEXCOORD2)) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = ((8.0 * tmpvar_13.w) * tmpvar_13.xyz);
  lmFull_4 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = ((8.0 * tmpvar_14.w) * tmpvar_14.xyz);
  lmIndirect_3 = tmpvar_17;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_7 * light_6.xyz);
  c_18.xyz = tmpvar_19;
  c_18.w = 0.0;
  c_2 = c_18;
  c_2.xyz = (c_2.xyz + tmpvar_8);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityShadows" 416 // 416 used size, 8 vars
Vector 400 [unity_ShadowFadeCenterAndType] 4
ConstBuffer "UnityPerDraw" 336 // 256 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
Matrix 64 [glstate_matrix_modelview0] 4
Matrix 192 [_Object2World] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityShadows" 2
BindCB "UnityPerDraw" 3
// 23 instructions, 2 temp regs, 0 temp arrays:
// ALU 10 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecedjifkdbnanelckdmcpmmmnheaoikjbmbdabaaaaaaieahaaaaaeaaaaaa
daaaaaaaieacaaaadeagaaaapmagaaaaebgpgodjemacaaaaemacaaaaaaacpopp
oiabaaaageaaaaaaafaaceaaaaaagaaaaaaagaaaaaaaceaaabaagaaaaaaaagaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaabjaaabaaadaaaaaaaaaa
adaaaaaaaiaaaeaaaaaaaaaaadaaamaaaeaaamaaaaaaaaaaaaaaaaaaaaacpopp
fbaaaaafbaaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacafaaaaia
aaaaapjabpaaaaacafaaaeiaaeaaapjaafaaaaadaaaaapiaaaaaffjaafaaoeka
aeaaaaaeaaaaapiaaeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaafaaaaad
abaaabiaaaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaiabaaaaakaafaaaaad
abaaafiaaaaapeiabaaaaakaacaaaaadaaaaadoaabaakkiaabaaomiaaeaaaaae
abaaadoaaeaaoejaabaaoekaabaaookaafaaaaadabaaahiaaaaaffjaanaaoeka
aeaaaaaeabaaahiaamaaoekaaaaaaajaabaaoeiaaeaaaaaeabaaahiaaoaaoeka
aaaakkjaabaaoeiaaeaaaaaeabaaahiaapaaoekaaaaappjaabaaoeiaacaaaaad
abaaahiaabaaoeiaadaaoekbafaaaaadacaaahoaabaaoeiaadaappkaafaaaaad
abaaabiaaaaaffjaajaakkkaaeaaaaaeabaaabiaaiaakkkaaaaaaajaabaaaaia
aeaaaaaeabaaabiaakaakkkaaaaakkjaabaaaaiaaeaaaaaeabaaabiaalaakkka
aaaappjaabaaaaiaabaaaaacabaaaiiaadaappkaacaaaaadabaaaciaabaappib
baaaffkaafaaaaadacaaaioaabaaffiaabaaaaibaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaamoaaaaaoeia
ppppaaaafdeieefckiadaaaaeaaaabaaokaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
bkaaaaaafjaaaaaeegiocaaaadaaaaaabaaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaaeaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
adaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaadaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
adaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaadaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaaaaaaaaaa
bkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaaabaaaaaa
agahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadpdgaaaaaf
mccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaakgakbaaa
abaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaaeaaaaaa
egiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadiaaaaaihcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiccaaaadaaaaaaanaaaaaadcaaaaakhcaabaaa
aaaaaaaaegiccaaaadaaaaaaamaaaaaaagbabaaaaaaaaaaaegacbaaaaaaaaaaa
dcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaaoaaaaaakgbkbaaaaaaaaaaa
egacbaaaaaaaaaaadcaaaaakhcaabaaaaaaaaaaaegiccaaaadaaaaaaapaaaaaa
pgbpbaaaaaaaaaaaegacbaaaaaaaaaaaaaaaaaajhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegiccaiaebaaaaaaacaaaaaabjaaaaaadiaaaaaihccabaaaadaaaaaa
egacbaaaaaaaaaaapgipcaaaacaaaaaabjaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaadaaaaaaafaaaaaadcaaaaakbcaabaaaaaaaaaaa
ckiacaaaadaaaaaaaeaaaaaaakbabaaaaaaaaaaaakaabaaaaaaaaaaadcaaaaak
bcaabaaaaaaaaaaackiacaaaadaaaaaaagaaaaaackbabaaaaaaaaaaaakaabaaa
aaaaaaaadcaaaaakbcaabaaaaaaaaaaackiacaaaadaaaaaaahaaaaaadkbabaaa
aaaaaaaaakaabaaaaaaaaaaaaaaaaaajccaabaaaaaaaaaaadkiacaiaebaaaaaa
acaaaaaabjaaaaaaabeaaaaaaaaaiadpdiaaaaaiiccabaaaadaaaaaabkaabaaa
aaaaaaaaakaabaiaebaaaaaaaaaaaaaadoaaaaabejfdeheomaaaaaaaagaaaaaa
aiaaaaaajiaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaalaaaaaaaabaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeo
ehefeofeaaeoepfcenebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 403
uniform highp vec4 unity_LightmapST;
uniform sampler2D _LightBuffer;
#line 415
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 419
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 404
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 407
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    o.lmapFadePos.xyz = (((_Object2World * v.vertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
    #line 411
    o.lmapFadePos.w = ((-(glstate_matrix_modelview0 * v.vertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.screen);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
    xlv_TEXCOORD2 = vec4(xl_retval.lmapFadePos);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
    highp vec4 lmapFadePos;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 403
uniform highp vec4 unity_LightmapST;
uniform sampler2D _LightBuffer;
#line 415
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp vec4 unity_Ambient;
#line 419
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 337
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 341
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 419
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    SurfaceOutput o;
    #line 423
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    o.Alpha = 0.0;
    #line 427
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    light = max( light, vec4( 0.001));
    #line 431
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmtex2 = texture( unity_LightmapInd, IN.lmap.xy);
    mediump float lmFade = ((length(IN.lmapFadePos) * unity_LightmapFade.z) + unity_LightmapFade.w);
    mediump vec3 lmFull = DecodeLightmap( lmtex);
    #line 435
    mediump vec3 lmIndirect = DecodeLightmap( lmtex2);
    mediump vec3 lm = mix( lmIndirect, lmFull, vec3( xll_saturate_f(lmFade)));
    light.xyz += lm;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    #line 439
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.screen = vec4(xlv_TEXCOORD0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD1);
    xlt_IN.lmapFadePos = vec4(xlv_TEXCOORD2);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
"!!ARBvp1.0
# 10 ALU
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[0].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[0].zw, R0;
MAD result.texcoord[1].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 10 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
"vs_2_0
; 10 ALU
def c7, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord1 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c7.x
mul r1.y, r1, c4.x
mad oT0.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT0.zw, r0
mad oT1.xy, v1, c6, c6.zwzw
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0
eefiecedcjajajpjdleogfkgconcmoliaphohkajabaaaaaaeaadaaaaadaaaaaa
cmaaaaaapeaaaaaageabaaaaejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahaaaaaalaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaa
abaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaafaaaaaaapaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfc
enebemaafeeffiedepepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklfdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaaacaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaaiccaabaaa
aaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaakncaabaaa
abaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadpaaaaaadp
dgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaaabaaaaaa
kgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
aeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaadoaaaaab
"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_9;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_11);
  light_3 = tmpvar_12;
  lowp vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_4 * tmpvar_12.xyz);
  c_13.xyz = tmpvar_14;
  c_13.w = 0.0;
  c_2 = c_13;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ProjectionParams;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = tmpvar_3.x;
  tmpvar_4.y = (tmpvar_3.y * _ProjectionParams.x);
  o_2.xy = (tmpvar_4 + tmpvar_3.w);
  o_2.zw = tmpvar_1.zw;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = o_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _LightBuffer;
uniform highp vec4 _Emission;
uniform highp vec4 _Color;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _Emission.xyz;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD0);
  light_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((8.0 * tmpvar_9.w) * tmpvar_9.xyz);
  lm_10 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = lm_10;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_12);
  light_3 = tmpvar_13;
  lowp vec4 c_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_4 * tmpvar_13.xyz);
  c_14.xyz = tmpvar_15;
  c_14.w = 0.0;
  c_2 = c_14;
  c_2.xyz = (c_2.xyz + tmpvar_5);
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord1" TexCoord1
Bind "color" Color
ConstBuffer "$Globals" 144 // 112 used size, 9 vars
Vector 96 [unity_LightmapST] 4
ConstBuffer "UnityPerCamera" 128 // 96 used size, 8 vars
Vector 80 [_ProjectionParams] 4
ConstBuffer "UnityPerDraw" 336 // 64 used size, 6 vars
Matrix 0 [glstate_matrix_mvp] 4
BindCB "$Globals" 0
BindCB "UnityPerCamera" 1
BindCB "UnityPerDraw" 2
// 11 instructions, 2 temp regs, 0 temp arrays:
// ALU 4 float, 0 int, 0 uint
// TEX 0 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"vs_4_0_level_9_1
eefiecednjpjmfldkhdlkelpenjfpdmkaplnmeniabaaaaaajmaeaaaaaeaaaaaa
daaaaaaaiiabaaaageadaaaacmaeaaaaebgpgodjfaabaaaafaabaaaaaaacpopp
aeabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaagaa
abaaabaaaaaaaaaaabaaafaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaaeiaaeaaapjaafaaaaadaaaaapia
aaaaffjaaeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaae
aaaaapiaafaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappja
aaaaoeiaafaaaaadabaaabiaaaaaffiaacaaaakaafaaaaadabaaaiiaabaaaaia
ahaaaakaafaaaaadabaaafiaaaaapeiaahaaaakaacaaaaadaaaaadoaabaakkia
abaaomiaaeaaaaaeabaaadoaaeaaoejaabaaoekaabaaookaaeaaaaaeaaaaadma
aaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaamoa
aaaaoeiappppaaaafdeieefcneabaaaaeaaaabaahfaaaaaafjaaaaaeegiocaaa
aaaaaaaaahaaaaaafjaaaaaeegiocaaaabaaaaaaagaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaaeaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadiaaaaai
ccaabaaaaaaaaaaabkaabaaaaaaaaaaaakiacaaaabaaaaaaafaaaaaadiaaaaak
ncaabaaaabaaaaaaagahbaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaaaaaaaaaadp
aaaaaadpdgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaaaaaaaaahdccabaaa
abaaaaaakgakbaaaabaaaaaamgaabaaaabaaaaaadcaaaaaldccabaaaacaaaaaa
egbabaaaaeaaaaaaegiacaaaaaaaaaaaagaaaaaaogikcaaaaaaaaaaaagaaaaaa
doaaaaabejfdeheomaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaakbaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaakjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaahaaaaaalaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaalaaaaaaaabaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaaljaaaaaaaaaaaaaaaaaaaaaaadaaaaaaafaaaaaa
apaaaaaafaepfdejfeejepeoaafeebeoehefeofeaaeoepfcenebemaafeeffied
epepfceeaaedepemepfcaaklepfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adamaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX

#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_Color _glesColor
in vec4 _glesColor;
#define gl_Normal (normalize(_glesNormal))
in vec3 _glesNormal;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;
#define gl_MultiTexCoord1 _glesMultiTexCoord1
in vec4 _glesMultiTexCoord1;
#define TANGENT vec4(normalize(_glesTANGENT.xyz), _glesTANGENT.w)
in vec4 _glesTANGENT;

#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
uniform highp vec4 unity_LightmapST;
#line 411
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 415
uniform lowp vec4 unity_Ambient;
#line 283
highp vec4 ComputeScreenPos( in highp vec4 pos ) {
    #line 285
    highp vec4 o = (pos * 0.5);
    o.xy = (vec2( o.x, (o.y * _ProjectionParams.x)) + o.w);
    o.zw = pos.zw;
    return o;
}
#line 403
v2f_surf vert_surf( in appdata_full v ) {
    v2f_surf o;
    #line 406
    o.pos = (glstate_matrix_mvp * v.vertex);
    o.screen = ComputeScreenPos( o.pos);
    o.lmap.xy = ((v.texcoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    return o;
}

out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main() {
    v2f_surf xl_retval;
    appdata_full xlt_v;
    xlt_v.vertex = vec4(gl_Vertex);
    xlt_v.tangent = vec4(TANGENT);
    xlt_v.normal = vec3(gl_Normal);
    xlt_v.texcoord = vec4(gl_MultiTexCoord0);
    xlt_v.texcoord1 = vec4(gl_MultiTexCoord1);
    xlt_v.color = vec4(gl_Color);
    xl_retval = vert_surf( xlt_v);
    gl_Position = vec4(xl_retval.pos);
    xlv_TEXCOORD0 = vec4(xl_retval.screen);
    xlv_TEXCOORD1 = vec2(xl_retval.lmap);
}


#endif
#ifdef FRAGMENT

#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];
mat2 xll_transpose_mf2x2(mat2 m) {
  return mat2( m[0][0], m[1][0], m[0][1], m[1][1]);
}
mat3 xll_transpose_mf3x3(mat3 m) {
  return mat3( m[0][0], m[1][0], m[2][0],
               m[0][1], m[1][1], m[2][1],
               m[0][2], m[1][2], m[2][2]);
}
mat4 xll_transpose_mf4x4(mat4 m) {
  return mat4( m[0][0], m[1][0], m[2][0], m[3][0],
               m[0][1], m[1][1], m[2][1], m[3][1],
               m[0][2], m[1][2], m[2][2], m[3][2],
               m[0][3], m[1][3], m[2][3], m[3][3]);
}
float xll_saturate_f( float x) {
  return clamp( x, 0.0, 1.0);
}
vec2 xll_saturate_vf2( vec2 x) {
  return clamp( x, 0.0, 1.0);
}
vec3 xll_saturate_vf3( vec3 x) {
  return clamp( x, 0.0, 1.0);
}
vec4 xll_saturate_vf4( vec4 x) {
  return clamp( x, 0.0, 1.0);
}
mat2 xll_saturate_mf2x2(mat2 m) {
  return mat2( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0));
}
mat3 xll_saturate_mf3x3(mat3 m) {
  return mat3( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0));
}
mat4 xll_saturate_mf4x4(mat4 m) {
  return mat4( clamp(m[0], 0.0, 1.0), clamp(m[1], 0.0, 1.0), clamp(m[2], 0.0, 1.0), clamp(m[3], 0.0, 1.0));
}
#line 150
struct v2f_vertex_lit {
    highp vec2 uv;
    lowp vec4 diff;
    lowp vec4 spec;
};
#line 186
struct v2f_img {
    highp vec4 pos;
    mediump vec2 uv;
};
#line 180
struct appdata_img {
    highp vec4 vertex;
    mediump vec2 texcoord;
};
#line 306
struct SurfaceOutput {
    lowp vec3 Albedo;
    lowp vec3 Normal;
    lowp vec3 Emission;
    mediump float Specular;
    lowp float Gloss;
    lowp float Alpha;
};
#line 382
struct Input {
    highp vec3 worldPos;
};
#line 395
struct v2f_surf {
    highp vec4 pos;
    highp vec4 screen;
    highp vec2 lmap;
};
#line 66
struct appdata_full {
    highp vec4 vertex;
    highp vec4 tangent;
    highp vec3 normal;
    highp vec4 texcoord;
    highp vec4 texcoord1;
    lowp vec4 color;
};
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
#line 3
uniform highp vec4 _CosTime;
uniform highp vec4 unity_DeltaTime;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
#line 7
uniform highp vec4 _ScreenParams;
uniform highp vec4 _ZBufferParams;
uniform highp vec4 unity_CameraWorldClipPlanes[6];
uniform highp vec4 _WorldSpaceLightPos0;
#line 11
uniform highp vec4 _LightPositionRange;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
#line 15
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_LightPosition[4];
uniform highp vec4 unity_LightAtten[4];
#line 19
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
#line 23
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp vec3 unity_LightColor0;
uniform highp vec3 unity_LightColor1;
uniform highp vec3 unity_LightColor2;
uniform highp vec3 unity_LightColor3;
#line 27
uniform highp vec4 unity_ShadowSplitSpheres[4];
uniform highp vec4 unity_ShadowSplitSqRadii;
uniform highp vec4 unity_LightShadowBias;
uniform highp vec4 _LightSplitsNear;
#line 31
uniform highp vec4 _LightSplitsFar;
uniform highp mat4 unity_World2Shadow[4];
uniform highp vec4 _LightShadowData;
uniform highp vec4 unity_ShadowFadeCenterAndType;
#line 35
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 glstate_matrix_invtrans_modelview0;
uniform highp mat4 _Object2World;
#line 39
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp mat4 glstate_matrix_transpose_modelview0;
uniform highp mat4 glstate_matrix_texture0;
#line 43
uniform highp mat4 glstate_matrix_texture1;
uniform highp mat4 glstate_matrix_texture2;
uniform highp mat4 glstate_matrix_texture3;
uniform highp mat4 glstate_matrix_projection;
#line 47
uniform highp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 unity_ColorSpaceGrey;
#line 76
#line 81
#line 86
#line 90
#line 95
#line 119
#line 136
#line 157
#line 165
#line 192
#line 205
#line 214
#line 219
#line 228
#line 233
#line 242
#line 259
#line 264
#line 290
#line 298
#line 302
#line 316
uniform lowp vec4 _LightColor0;
uniform lowp vec4 _SpecColor;
#line 329
#line 337
#line 351
#line 387
uniform highp vec4 _Color;
uniform highp vec4 _Emission;
uniform highp vec4 _Ambient;
#line 402
uniform highp vec4 unity_LightmapST;
#line 411
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
#line 415
uniform lowp vec4 unity_Ambient;
#line 176
lowp vec3 DecodeLightmap( in lowp vec4 color ) {
    #line 178
    return (2.0 * color.xyz);
}
#line 316
mediump vec3 DirLightmapDiffuse( in mediump mat3 dirBasis, in lowp vec4 color, in lowp vec4 scale, in mediump vec3 normal, in bool surfFuncWritesNormal, out mediump vec3 scalePerBasisVector ) {
    mediump vec3 lm = DecodeLightmap( color);
    scalePerBasisVector = DecodeLightmap( scale);
    #line 320
    if (surfFuncWritesNormal){
        mediump vec3 normalInRnmBasis = xll_saturate_vf3((dirBasis * normal));
        lm *= dot( normalInRnmBasis, scalePerBasisVector);
    }
    #line 325
    return lm;
}
#line 344
mediump vec4 LightingLambert_DirLightmap( in SurfaceOutput s, in lowp vec4 color, in lowp vec4 scale, in bool surfFuncWritesNormal ) {
    #line 346
    highp mat3 unity_DirBasis = xll_transpose_mf3x3(mat3( vec3( 0.816497, 0.0, 0.57735), vec3( -0.408248, 0.707107, 0.57735), vec3( -0.408248, -0.707107, 0.57735)));
    mediump vec3 scalePerBasisVector;
    mediump vec3 lm = DirLightmapDiffuse( unity_DirBasis, color, scale, s.Normal, surfFuncWritesNormal, scalePerBasisVector);
    return vec4( lm, 0.0);
}
#line 337
lowp vec4 LightingLambert_PrePass( in SurfaceOutput s, in mediump vec4 light ) {
    lowp vec4 c;
    c.xyz = (s.Albedo * light.xyz);
    #line 341
    c.w = s.Alpha;
    return c;
}
#line 390
void surf( in Input IN, inout SurfaceOutput o ) {
    #line 392
    o.Albedo = _Color.xyz;
    o.Emission = _Emission.xyz;
}
#line 416
lowp vec4 frag_surf( in v2f_surf IN ) {
    Input surfIN;
    #line 419
    SurfaceOutput o;
    o.Albedo = vec3( 0.0);
    o.Emission = vec3( 0.0);
    o.Specular = 0.0;
    #line 423
    o.Alpha = 0.0;
    o.Gloss = 0.0;
    surf( surfIN, o);
    mediump vec4 light = textureProj( _LightBuffer, IN.screen);
    #line 427
    light = max( light, vec4( 0.001));
    lowp vec4 lmtex = texture( unity_Lightmap, IN.lmap.xy);
    lowp vec4 lmIndTex = texture( unity_LightmapInd, IN.lmap.xy);
    mediump vec4 lm = LightingLambert_DirLightmap( o, lmtex, lmIndTex, false);
    #line 431
    light += lm;
    mediump vec4 c = LightingLambert_PrePass( o, light);
    c.xyz += o.Emission;
    return c;
}
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main() {
    lowp vec4 xl_retval;
    v2f_surf xlt_IN;
    xlt_IN.pos = vec4(0.0);
    xlt_IN.screen = vec4(xlv_TEXCOORD0);
    xlt_IN.lmap = vec2(xlv_TEXCOORD1);
    xl_retval = frag_surf( xlt_IN);
    gl_FragData[0] = vec4(xl_retval);
}


#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 5 to 19, TEX: 1 to 3
//   d3d9 - ALU: 5 to 17, TEX: 1 to 3
//   d3d11 - ALU: 2 to 8, TEX: 1 to 3, FLOW: 1 to 1
//   d3d11_9x - ALU: 2 to 8, TEX: 1 to 3, FLOW: 1 to 1
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 8 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEMP R1;
TXP R0.xyz, fragment.texcoord[0], texture[0], 2D;
MOV R1.xyz, c[1];
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
ADD R0.xyz, -R0, fragment.texcoord[1];
MAD result.color.xyz, R0, c[0], R1;
MOV result.color.w, c[2].x;
END
# 8 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
"ps_2_0
; 8 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
texldp r0, t0, s0
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r1.xyz, -r0, t1
mov_pp r0.xyz, c1
mov_pp r0.w, c2.x
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedbhchpopcihhkmipcpedkdgdidlieamdcabaaaaaapaabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbiabaaaaeaaaaaaaegaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaacaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
// 7 instructions, 1 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedohdoihokancghacblpkbmmmojnpeeejeabaaaaaaamadaaaaaeaaaaaa
daaaaaaaeiabaaaagiacaaaaniacaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
nmaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahla
bpaaaaacaaaaaajaaaaiapkaagaaaaacaaaaaiiaaaaapplaafaaaaadaaaaadia
aaaappiaaaaaoelaecaaaaadaaaacpiaaaaaoeiaaaaioekaapaaaaacabaacbia
aaaaaaiaapaaaaacabaacciaaaaaffiaapaaaaacabaaceiaaaaakkiaacaaaaad
aaaachiaabaaoeibabaaoelaabaaaaacabaaahiaaaaaoekaaeaaaaaeaaaachia
abaaoeiaaaaaoeiaabaaoekaabaaaaacaaaaciiaacaaaakaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbiabaaaaeaaaaaaaegaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
abaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaa
acaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaa
aaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaa
aaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaahahaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R0, fragment.texcoord[1], texture[2], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[3].y;
DP4 R1.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[3].y, -R0;
MAD_SAT R0.w, R0, c[2].z, c[2];
MAD R0.xyz, R0.w, R1, R0;
MOV R1.xyz, c[1];
LG2 R2.x, R2.x;
LG2 R2.y, R2.y;
LG2 R2.z, R2.z;
ADD R0.xyz, -R2, R0;
MAD result.color.xyz, R0, c[0], R1;
MOV result.color.w, c[3].x;
END
# 19 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 17 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
texldp r1, t0, s0
texld r2, t1, s1
texld r0, t1, s2
mul_pp r3.xyz, r2.w, r2
mul_pp r2.xyz, r0.w, r0
mul_pp r2.xyz, r2, c3.x
dp4 r0.x, t2, t2
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r3.xyz, r3, c3.x, -r2
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r3, r2
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
add_pp r1.xyz, -r1, r0
mov_pp r0.xyz, c1
mov_pp r0.w, c3.y
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 144 // 128 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
Vector 112 [unity_LightmapFade] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
SetTexture 2 [unity_LightmapInd] 2D 2
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgibopoalpibmoppnfpoagaaojmdaaiceabaaaaaajaadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaacaaaaeaaaaaaakiaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
ahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaa
abaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaa
adaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaa
aaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 144 // 128 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
Vector 112 [unity_LightmapFade] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
SetTexture 2 [unity_LightmapInd] 2D 2
// 17 instructions, 2 temp regs, 0 temp arrays:
// ALU 8 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecednnboidjkkikimlnmknjlbophbndedgokabaaaaaajiafaaaaaeaaaaaa
daaaaaaadeacaaaanmaeaaaageafaaaaebgpgodjpmabaaaapmabaaaaaaacpppp
leabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaagaaaaacaaaaaiiaaaaapplaafaaaaadaaaaadiaaaaappiaaaaaoela
ecaaaaadabaacpiaabaaoelaacaioekaecaaaaadacaacpiaabaaoelaabaioeka
ecaaaaadaaaacpiaaaaaoeiaaaaioekaajaaaaadaaaaaiiaacaaoelaacaaoela
ahaaaaacaaaaaiiaaaaappiaagaaaaacaaaaaiiaaaaappiaaeaaaaaeaaaadiia
aaaappiaacaakkkaacaappkaafaaaaadabaaciiaabaappiaadaaaakaafaaaaad
abaachiaabaaoeiaabaappiaafaaaaadabaaciiaacaappiaadaaaakaaeaaaaae
acaachiaabaappiaacaaoeiaabaaoeibaeaaaaaeabaachiaaaaappiaacaaoeia
abaaoeiaapaaaaacacaacbiaaaaaaaiaapaaaaacacaacciaaaaaffiaapaaaaac
acaaceiaaaaakkiaacaaaaadaaaachiaabaaoeiaacaaoeibabaaaaacabaaahia
aaaaoekaaeaaaaaeaaaachiaabaaoeiaaaaaoeiaabaaoekaabaaaaacaaaaciia
adaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckaacaaaaeaaaaaaa
kiaaaaaafjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaa
acaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
bbaaaaahbcaabaaaaaaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaaf
bcaabaaaaaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaa
aaaaaaaackiacaaaaaaaaaaaahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaah
ocaabaaaaaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaa
abaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaa
aaaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaacpaaaaafhcaabaaaabaaaaaaegacbaaaabaaaaaaaaaaaaaihcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadcaaaaalhccabaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapalaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 10 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TXP R0.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
MUL R1.xyz, R1.w, R1;
MOV R2.xyz, c[1];
LG2 R0.x, R0.x;
LG2 R0.z, R0.z;
LG2 R0.y, R0.y;
MAD R0.xyz, R1, c[2].y, -R0;
MAD result.color.xyz, R0, c[0], R2;
MOV result.color.w, c[2].x;
END
# 10 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 9 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1.xy
texld r0, t1, s1
texldp r1, t0, s0
mul_pp r0.xyz, r0.w, r0
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
mad_pp r1.xyz, r0, c2.x, -r1
mov_pp r0.xyz, c1
mov_pp r0.w, c2.y
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 144 // 80 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedgnghpficfhholpopfifeneefdlobmfigabaaaaaafeacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmabaaaaeaaaaaaafpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaacpaaaaafhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaa
abeaaaaaaaaaaaebdcaaaaakhcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaa
aaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaf
iccabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
ConstBuffer "$Globals" 144 // 80 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 9 instructions, 2 temp regs, 0 temp arrays:
// ALU 3 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedfjpjpmkdaaghjfjknakmeecmknddemolabaaaaaakeadaaaaaeaaaaaa
daaaaaaahmabaaaaaaadaaaahaadaaaaebgpgodjeeabaaaaeeabaaaaaaacpppp
amabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaaaaapplaafaaaaadaaaaadiaaaaappiaaaaaoelaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaabaaoelaabaioekaapaaaaacacaacbia
aaaaaaiaapaaaaacacaacciaaaaaffiaapaaaaacacaaceiaaaaakkiaafaaaaad
abaaciiaabaappiaacaaaakaaeaaaaaeaaaachiaabaappiaabaaoeiaacaaoeib
abaaaaacabaaahiaaaaaoekaaeaaaaaeaaaachiaabaaoeiaaaaaoeiaabaaoeka
abaaaaacaaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
hmabaaaaeaaaaaaafpaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
cpaaaaafhcaabaaaaaaaaaaaegacbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaadcaaaaal
hccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapalaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 5 ALU, 1 TEX
PARAM c[3] = { program.local[0..1],
		{ 0 } };
TEMP R0;
TEMP R1;
TXP R0.xyz, fragment.texcoord[0], texture[0], 2D;
MOV R1.xyz, c[1];
ADD R0.xyz, R0, fragment.texcoord[1];
MAD result.color.xyz, R0, c[0], R1;
MOV result.color.w, c[2].x;
END
# 5 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
"ps_2_0
; 5 ALU, 1 TEX
dcl_2d s0
def c2, 0.00000000, 0, 0, 0
dcl t0
dcl t1.xyz
texldp r0, t0, s0
add_pp r1.xyz, r0, t1
mov_pp r0.xyz, c1
mov_pp r0.w, c2.x
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedjkknccnihdicnhlijkllcfilenchcjeoabaaaaaaniabaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaabaaaaeaaaaaaaeaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaacaaaaaadcaaaaalhccabaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 112 // 80 used size, 7 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
// 6 instructions, 1 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 1 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedjabbhaafgpikfgglcmainkjkahibcbifabaaaaaanaacaaaaaeaaaaaa
daaaaaaaceabaaaacmacaaaajmacaaaaebgpgodjomaaaaaaomaaaaaaaaacpppp
liaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaaaaaaaaaaa
aaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaahla
bpaaaaacaaaaaajaaaaiapkaagaaaaacaaaaaiiaaaaapplaafaaaaadaaaaadia
aaaappiaaaaaoelaecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadaaaachia
aaaaoeiaabaaoelaabaaaaacabaaahiaaaaaoekaaeaaaaaeaaaachiaabaaoeia
aaaaoeiaabaaoekaabaaaaacaaaaciiaacaaaakaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcaaabaaaaeaaaaaaaeaaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadlcbabaaaabaaaaaagcbaaaadhcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaabaaaaaa
pgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egbcbaaaacaaaaaadcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaa
egacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaa
abeaaaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
ahahaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Vector 1 [_Emission]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 3 TEX
PARAM c[4] = { program.local[0..2],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[1], texture[2], 2D;
TEX R1, fragment.texcoord[1], texture[1], 2D;
TXP R2.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[3].y;
DP4 R1.w, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[3].y, -R0;
MAD_SAT R0.w, R0, c[2].z, c[2];
MAD R0.xyz, R0.w, R1, R0;
MOV R1.xyz, c[1];
ADD R0.xyz, R2, R0;
MAD result.color.xyz, R0, c[0], R1;
MOV result.color.w, c[3].x;
END
# 16 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Vector 1 [_Emission]
Vector 2 [unity_LightmapFade]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
SetTexture 2 [unity_LightmapInd] 2D
"ps_2_0
; 14 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c3, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2
texldp r1, t0, s0
texld r0, t1, s1
texld r3, t1, s2
mul_pp r2.xyz, r0.w, r0
dp4 r0.x, t2, t2
mul_pp r3.xyz, r3.w, r3
mul_pp r3.xyz, r3, c3.x
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r2.xyz, r2, c3.x, -r3
mad_sat r0.x, r0, c2.z, c2.w
mad_pp r0.xyz, r0.x, r2, r3
add_pp r1.xyz, r1, r0
mov_pp r0.xyz, c1
mov_pp r0.w, c3.y
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 144 // 128 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
Vector 112 [unity_LightmapFade] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
SetTexture 2 [unity_LightmapInd] 2D 2
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedaoblakddgdpbnddandhehkekajecaogdabaaaaaahiadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefciiacaaaaeaaaaaaakcaaaaaafjaaaaaeegiocaaa
aaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
lcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabbaaaaahbcaabaaaaaaaaaaa
egbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaafbcaabaaaaaaaaaaaakaabaaa
aaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaa
ahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaahccaabaaaaaaaaaaa
dkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaaaaaaaaaaagajbaaa
abaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaaabaaaaaadkaabaaa
abaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaapgapbaaaabaaaaaa
egacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaajhcaabaaaaaaaaaaa
agaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaalhccabaaaaaaaaaaa
egiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaaaeaaaaaa
dgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 144 // 128 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
Vector 112 [unity_LightmapFade] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
SetTexture 2 [unity_LightmapInd] 2D 2
// 16 instructions, 2 temp regs, 0 temp arrays:
// ALU 7 float, 0 int, 0 uint
// TEX 3 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedmoibgdgpkpdgejanmafkigjdefdpiabcabaaaaaafmafaaaaaeaaaaaa
daaaaaaabaacaaaakaaeaaaaciafaaaaebgpgodjniabaaaaniabaaaaaaacpppp
jaabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaaaaaaaaa
abababaaacacacaaaaaaadaaacaaaaaaaaaaaaaaaaaaahaaabaaacaaaaaaaaaa
aaacppppfbaaaaafadaaapkaaaaaaaebaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaapla
bpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaaja
acaiapkaagaaaaacaaaaaiiaaaaapplaafaaaaadaaaaadiaaaaappiaaaaaoela
ecaaaaadabaacpiaabaaoelaacaioekaecaaaaadacaacpiaabaaoelaabaioeka
ecaaaaadaaaacpiaaaaaoeiaaaaioekaajaaaaadaaaaaiiaacaaoelaacaaoela
ahaaaaacaaaaaiiaaaaappiaagaaaaacaaaaaiiaaaaappiaaeaaaaaeaaaadiia
aaaappiaacaakkkaacaappkaafaaaaadabaaciiaabaappiaadaaaakaafaaaaad
abaachiaabaaoeiaabaappiaafaaaaadabaaciiaacaappiaadaaaakaaeaaaaae
acaachiaabaappiaacaaoeiaabaaoeibaeaaaaaeabaachiaaaaappiaacaaoeia
abaaoeiaacaaaaadaaaachiaaaaaoeiaabaaoeiaabaaaaacabaaahiaaaaaoeka
aeaaaaaeaaaachiaabaaoeiaaaaaoeiaabaaoekaabaaaaacaaaaciiaadaaffka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefciiacaaaaeaaaaaaakcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaabbaaaaah
bcaabaaaaaaaaaaaegbobaaaadaaaaaaegbobaaaadaaaaaaelaaaaafbcaabaaa
aaaaaaaaakaabaaaaaaaaaaadccaaaalbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
ckiacaaaaaaaaaaaahaaaaaadkiacaaaaaaaaaaaahaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaah
ccaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdiaaaaahocaabaaa
aaaaaaaaagajbaaaabaaaaaafgafbaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
abaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaakhcaabaaaabaaaaaa
pgapbaaaabaaaaaaegacbaaaabaaaaaajgahbaiaebaaaaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaagaabaaaaaaaaaaaegacbaaaabaaaaaajgahbaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaal
hccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaa
aaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapalaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 2 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[1], texture[1], 2D;
TXP R0.xyz, fragment.texcoord[0], texture[0], 2D;
MUL R1.xyz, R1.w, R1;
MOV R2.xyz, c[1];
MAD R0.xyz, R1, c[2].y, R0;
MAD result.color.xyz, R0, c[0], R2;
MOV result.color.w, c[2].x;
END
# 7 instructions, 3 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [_Color]
Vector 1 [_Emission]
SetTexture 0 [_LightBuffer] 2D
SetTexture 1 [unity_Lightmap] 2D
"ps_2_0
; 6 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c2, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1.xy
texld r0, t1, s1
texldp r1, t0, s0
mul_pp r0.xyz, r0.w, r0
mad_pp r1.xyz, r0, c2.x, r1
mov_pp r0.xyz, c1
mov_pp r0.w, c2.y
mad_pp r0.xyz, r1, c0, r0
mov_pp oC0, r0
"
}

SubProgram "d3d11 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 144 // 80 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0
eefiecedaialdcdbfgbflgoajnkhapeekicjigeiabaaaaaadmacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgeabaaaaeaaaaaaafjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaajhcaabaaaaaaaaaaa
pgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadcaaaaalhccabaaa
aaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaaegiccaaaaaaaaaaa
aeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaadoaaaaab"
}

SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "d3d11_9x " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
ConstBuffer "$Globals" 144 // 80 used size, 9 vars
Vector 48 [_Color] 4
Vector 64 [_Emission] 4
BindCB "$Globals" 0
SetTexture 0 [_LightBuffer] 2D 0
SetTexture 1 [unity_Lightmap] 2D 1
// 8 instructions, 2 temp regs, 0 temp arrays:
// ALU 2 float, 0 int, 0 uint
// TEX 2 (0 load, 0 comp, 0 bias, 0 grad)
// FLOW 1 static, 0 dynamic
"ps_4_0_level_9_1
eefiecedplamocfobfnalcngnjboijkhabdajomoabaaaaaagiadaaaaaeaaaaaa
daaaaaaafiabaaaameacaaaadeadaaaaebgpgodjcaabaaaacaabaaaaaaacpppp
oiaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaadaaacaaaaaaaaaaaaaaaaacppppfbaaaaafacaaapkaaaaaaaeb
aaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaaadlabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaaaaapplaafaaaaadaaaaadiaaaaappiaaaaaoelaecaaaaadaaaacpia
aaaaoeiaaaaioekaecaaaaadabaacpiaabaaoelaabaioekaafaaaaadaaaaciia
abaappiaacaaaakaaeaaaaaeaaaachiaaaaappiaabaaoeiaaaaaoeiaabaaaaac
abaaahiaaaaaoekaaeaaaaaeaaaachiaabaaoeiaaaaaoeiaabaaoekaabaaaaac
aaaaciiaacaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcgeabaaaa
eaaaaaaafjaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadlcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaabaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaaabeaaaaaaaaaaaebdcaaaaaj
hcaabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
dcaaaaalhccabaaaaaaaaaaaegiccaaaaaaaaaaaadaaaaaaegacbaaaaaaaaaaa
egiccaaaaaaaaaaaaeaaaaaadgaaaaaficcabaaaaaaaaaaaabeaaaaaaaaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apalaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}

SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}

}
	}

#LINE 28

	
    }
} 