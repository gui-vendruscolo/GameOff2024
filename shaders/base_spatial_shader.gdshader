shader_type spatial;

uniform sampler2D screen_texture : hint_screen_texture, filter_linear;
uniform sampler2D normal_texture : hint_screen_texture, filter_linear;
uniform sampler2D depth_texture : hint_depth_texture, filter_linear;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 tex_color = texture(screen_texture, SCREEN_UV);
	vec4 normal_color = texture(normal_texture, SCREEN_UV);
	float roughness = texture(normal_texture, SCREEN_UV).w;
	
	float depth_range = 35.;
	float depth = texture(depth_texture, SCREEN_UV).x;
	vec3 ndc = vec3(SCREEN_UV * 2. - 1., depth); // aka clip_plane
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.);
	view.xyz /= view.w;
	float linear_depth = -view.z / depth_range;
	
	vec3 fog = vec3(linear_depth);
}