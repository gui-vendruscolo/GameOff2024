shader_type canvas_item;

const vec3 PALETTE[32] = vec3[](
    vec3(0.356, 0.651, 0.459),  // #5ba675
    vec3(0.420, 0.788, 0.424),  // #6bc96c
    vec3(0.671, 0.867, 0.392),  // #abdd64
    vec3(0.988, 0.937, 0.553),  // #fcef8d
    vec3(1.000, 0.722, 0.475),  // #ffb879
    vec3(0.918, 0.384, 0.384),  // #ea6262
    vec3(0.800, 0.259, 0.369),  // #cc425e
    vec3(0.639, 0.157, 0.345),  // #a32858
    vec3(0.459, 0.090, 0.337),  // #751756
    vec3(0.224, 0.035, 0.278),  // #390947
    vec3(0.380, 0.094, 0.318),  // #611851
    vec3(0.529, 0.208, 0.333),  // #873555
    vec3(0.651, 0.333, 0.373),  // #a6555f
    vec3(0.788, 0.451, 0.451),  // #c97373
    vec3(0.949, 0.682, 0.600),  // #f2ae99
    vec3(1.000, 0.765, 0.949),  // #ffc3f2
    vec3(0.933, 0.561, 0.796),  // #ee8fcb
    vec3(0.831, 0.431, 0.702),  // #d46eb3
    vec3(0.529, 0.243, 0.518),  // #873e84
    vec3(0.122, 0.063, 0.165),  // #1f102a
    vec3(0.290, 0.188, 0.322),  // #4a3052
    vec3(0.482, 0.329, 0.502),  // #7b5480
    vec3(0.651, 0.522, 0.624),  // #a6859f
    vec3(0.851, 0.741, 0.784),  // #d9bdc8
    vec3(0.682, 0.886, 1.000),  // #aee2ff
    vec3(0.553, 0.718, 1.000),  // #8db7ff
    vec3(0.427, 0.502, 0.980),  // #6d80fa
    vec3(0.518, 0.396, 0.925),  // #8465ec
    vec3(0.514, 0.302, 0.769),  // #834dc4
    vec3(0.490, 0.176, 0.627),  // #7d2da0
    vec3(0.306, 0.094, 0.486),  // #4e187c
    vec3(0.945, 0.945, 0.945)   // #f1f1f1
);

const int PALETTE_SIZE = 32;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;

vec3 find_closest_color(vec3 color) {
    float min_distance = distance(color, PALETTE[0]);
    vec3 closest_color = PALETTE[0];

    for (int i = 1; i < PALETTE_SIZE; i++) {
        float dist = distance(color, PALETTE[i]);
        if (dist < min_distance) {
            min_distance = dist;
            closest_color = PALETTE[i];
        }
    }
    return closest_color;
}

void fragment() {
	vec4 tex_color = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec3 closest_color = find_closest_color(tex_color.rgb);

	COLOR = vec4(closest_color, tex_color.a);
}