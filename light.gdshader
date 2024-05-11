shader_type canvas_item;
render_mode light_only;


uniform float angle = 1.f;
uniform float range = 1.f;
const vec2 center = vec2(0.45,0.5);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if(dot(vec2(1.f,0.f),normalize(UV - center)) > angle){
		COLOR *= min(1.f,dot(vec2(1.f,0.f),normalize(UV - center)) - angle);
	}
	else{
		COLOR.a = 0.f;
	}
	COLOR *= pow(range - distance(center,UV),2.f);
}

