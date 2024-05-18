shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform float intense = 1.0;
uniform bool web = false;

void vertex() {
}

void fragment() {
	vec3 clr;
 	float toRadians = 3.14 / 180.;
	float rand = fract
        ( 10000.0
        * sin
            (
              ( SCREEN_UV.x
              + SCREEN_UV.y
              * TIME
              )
            * 30.0
            )
        );
	float rand2 = fract
        ( 10000.0
        * sin
            (
              ( SCREEN_UV.x
              + SCREEN_UV.y
              * TIME * 4. - 100.
              )
            * 40.0
            )
        );
		
	clr = textureLod(SCREEN_TEXTURE,SCREEN_UV + vec2(0.0008,0.00082) * sin(TIME * 100.) * rand,0.0).rgb;
	rand /= intense;
	rand = rand;
	clr.rgb += vec3(rand) * clr.r;
	
	COLOR.rgb = clr;
}
