shader_type canvas_item;

uniform float skew = 0.0;

void vertex() {
	VERTEX.x += skew * (1.0 - UV.y);
}

void fragment() {
	
}

