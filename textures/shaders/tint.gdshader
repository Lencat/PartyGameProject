shader_type canvas_item;

uniform vec4 tint;
uniform float alpha;

void fragment() {
	COLOR = texture(TEXTURE, UV);
	COLOR.r = mix(COLOR.r, tint.r, tint.a);
	COLOR.g = mix(COLOR.g, tint.g, tint.a);
	COLOR.b = mix(COLOR.b, tint.b, tint.a);
	COLOR.a *= alpha;
}
