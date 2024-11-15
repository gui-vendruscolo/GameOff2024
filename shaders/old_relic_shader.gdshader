shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear;
uniform sampler2D normal_texture : hint_screen_texture, filter_linear;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 uv = SCREEN_UV;
	vec3 tex_color = texture(screen_texture, uv).rgb;
	vec3 relic_color = mix(tex_color, vec3(0.506, 0.282, 1), 0.4);
	float r = relic_color.r;
	float g = relic_color.g;
	float b = relic_color.b;
	float a = uv.x > 0.999 || uv.x < 0.001 || uv.y > 0.999 || uv.y < 0.001? 1. : 0.2;
	COLOR = vec4(r,g,b,a);
	
	
}

