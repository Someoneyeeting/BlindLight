shader_type canvas_item;


uniform bool lighton = false;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(lighton){
		COLOR.rgb = vec3(0.6);
	}
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
