#version 330 compatibility

#include "/lib/distort.glsl"

uniform sampler2D colortex0;
uniform sampler2D depthtex0;
uniform vec3 fogColor;
uniform float far;
uniform mat4 gbufferProjectionInverse;
#define FOG_DENSITY 5.0
in vec2 texcoord;

vec3 projectAndDivide(mat4 projectionMatrix, vec3 position){
  vec4 homPos = projectionMatrix * vec4(position, 1.0);
  return homPos.xyz / homPos.w;
}

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
  color = texture(colortex0, texcoord);

  float depth = texture(depthtex0, texcoord).r;
  if(depth == 1.0){
    return;
  }

  vec3 NDCPos = vec3(texcoord.xy, depth) * 2.0 - 1.0;
  vec3 viewPos = projectAndDivide(gbufferProjectionInverse, NDCPos);

  float dist = length(viewPos) / far;
    float fogFactor = exp(-FOG_DENSITY * (1.0 - dist));

color.rgb = mix(color.rgb, fogColor, clamp(fogFactor, 0.0, 1.0));
}