shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
uniform vec2 r_displacement = vec2(0.5, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-0.5, 0.0);
uniform float pixelate : hint_range(2, 1024, 4) = 1024;

void fragment()
{
	float r = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*r_displacement), 0.0).r;
	float g = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*g_displacement), 0.0).g;
	float b = texture(SCREEN_TEXTURE, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*b_displacement), 0.0).b;
	vec2 uv = floor(UV * pixelate)/ pixelate;
	
	vec4 pixel = textureLod(SCREEN_TEXTURE, uv, 0.0);
	vec4 chromatic_aberration_color = vec4(r, g, b, 1.0);
	COLOR = chromatic_aberration_color;
	//COLOR = mix(pixel, chromatic_aberration_color, 0.2);
}
