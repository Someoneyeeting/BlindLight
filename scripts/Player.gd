extends CharacterBody2D



@export var speed :float=30.
@export var grav :float= 9.8
@export var jumpheight :float = 30
var flashlighton = true
var lightrange = 0.975
var lightintense = 0.975
var lightbattery :float= 1

func _ready() -> void:
	up_direction = Vector2.UP
	pass
	
func _physics_process(delta: float) -> void:
	if(is_on_floor()):
		if(velocity.y > 0):
			velocity.y = 0
		if(Input.is_action_just_pressed("jump")):
			velocity.y = -jumpheight
	
	if(Input.is_action_just_pressed("rclick")):
		flashlighton = !flashlighton
	$flashlight.visible = flashlighton
	
	
	if(flashlighton):
		lightbattery -= delta / 500
		$flashlight.get_node("back").material.set_shader_parameter("range",lightrange * lightbattery)
		$flashlight.get_node("back").material.set_shader_parameter("intens",lightintense * lightbattery)
		if(Input.is_action_pressed("lclick")):
			lightrange = lerp(lightrange,1.14,0.3)
			lightintense = lerp(lightintense,1.5,0.3)
			lightbattery -= delta / 500
		else:
			lightrange = lerp(lightrange,0.9,0.3)
			lightintense = lerp(lightintense,2.0,0.3)
	
	velocity.y += grav
	
	velocity.x = lerp(velocity.x,(Input.get_action_strength("right") - Input.get_action_strength("left")) * speed,0.2)
	
	$flashlight.look_at(get_global_mouse_position())
	
	move_and_slide()
	
