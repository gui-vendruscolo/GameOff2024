shader_type spatial;
render_mode unshaded;

uniform sampler2D depth_tex : hint_depth_texture;
uniform sampler2D screen_tex : hint_screen_texture, filter_linear;
uniform sampler2D normal_texture : hint_screen_texture, filter_linear;

uniform vec2 r_displacement = vec2(0.2, 0.0);
uniform vec2 g_displacement = vec2(0.0, 0.0);
uniform vec2 b_displacement = vec2(-0.2, 0.0);

void vertex() {
	 POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	vec3 tex_color = texture(screen_tex, SCREEN_UV).rgb;
	float roughness = texture(normal_texture, SCREEN_UV).w;

	float depth_range = 60.;
	float depth = texture(depth_tex, SCREEN_UV).x;
	vec3 ndc = vec3(SCREEN_UV * 2. - 1., depth); // aka clip_plane
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.);
	view.xyz /= view.w;
	float linear_depth = -view.z / depth_range;
	float r = texture(screen_tex, SCREEN_UV + vec2(1.0/VIEWPORT_SIZE * r_displacement), 0.).r;
	float g = texture(screen_tex, SCREEN_UV + vec2(1.0/VIEWPORT_SIZE * g_displacement), 0.).g;
	float b = texture(screen_tex, SCREEN_UV + vec2(1.0/VIEWPORT_SIZE * b_displacement), 0.).b;
	
	vec3 fog_color = vec3(0.5, 0.7, 1.0); // cor da nevoa (por exemplo, azul claro)
	vec3 fog = fog_color * linear_depth;
	//vec3 bloom_color = vec3(0.867, 0.627, 0.867);
	//vec3 bloom_color = vec3(0.11, 0.039, 0.302);
	vec3 bloom_color = vec3(0.043, 0.055, 0.09);
	vec3 grayscale_color = vec3(0.005);
	
	float bloom_intensity = smoothstep(0.2, 1, linear_depth); // mais bloom com profundidade maior
	float desaturation = smoothstep(0.6, 1.0, linear_depth);
	vec3 bloom_effect = bloom_color * bloom_intensity;
	vec3 desaturated_color = mix(tex_color, grayscale_color, desaturation);
	vec3 color = desaturated_color * roughness + bloom_effect;
	
	ALBEDO = color;
}