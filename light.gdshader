shader_type canvas_item;
render_mode light_only;


uniform float angle = 1.f;
uniform float range = 1.f;
uniform float intens = 1.f;
uniform float off = 0.1f;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 center = vec2(.5f - off,0.5);
	if(dot(vec2(1.f,0.f),normalize(UV - center)) > angle && dot(vec2(1.f,0.f),normalize(UV - vec2(0.5))) > 0.){
		COLOR *= min(1.f,dot(vec2(1.f,0.f),normalize(UV - center)) - angle	);
	}
	else{
		COLOR.a = 0.f;
	}
	COLOR *= pow(range - distance(center,UV),2.f);
	
	COLOR *= intens;
}

