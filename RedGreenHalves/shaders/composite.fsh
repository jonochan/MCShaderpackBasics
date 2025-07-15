#version 330 compatibility

uniform sampler2D colortex0;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(colortex0, texcoord);
	if(texcoord.x < 0.5){
		color.rgb = color.rgb * vec3(1.5, 0.5, 0.5);
	}
	else {
		color.rgb = color.rgb * vec3(0.5, 1.5, 0.5);
	}
}