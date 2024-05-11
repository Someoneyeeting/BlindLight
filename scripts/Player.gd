extends CharacterBody2D



@export var speed :float=30.
@export var grav :float= 9.8
@export var jumpheight :float = 30
var flashlighton = true
var lightrange = 0.975
var lightintense = 0.975
var lightbattery :float= 1
var wasinair = false


func _ready() -> void:
	LightManger.player = self
	up_direction = Vector2.UP
	pass
	
func _physics_process(delta: float) -> void:
	if(is_on_floor()):
		if(velocity.y > 0):
			velocity.y = 0
		if(Input.is_action_just_pressed("jump")):
			velocity.y = -jumpheight
	else:
		wasinair = true
	
	if(Input.is_action_just_pressed("rclick")):
		LightManger.switch()
		#flashlighton = !flashlighton
	$flashlight.visible = flashlighton
	
	
	if(flashlighton):
		lightbattery -= delta / 500
		$flashlight.get_node("back").material.set_shader_parameter("range",lightrange * lightbattery)
		$flashlight.get_node("back").material.set_shader_parameter("intens",lightintense * lightbattery)
		if(Input.is_action_pressed("lclick")):
			lightrange = lerp(lightrange,0.9,0.3)
			lightintense = lerp(lightintense,2.7,0.3)
			lightbattery -= delta / 200
		else:
			lightrange = lerp(lightrange,0.62,0.3)
			lightintense = lerp(lightintense,3.96,0.3)
	
	velocity.y += grav
	
	
	velocity.x = lerp(velocity.x,(Input.get_action_strength("right") - Input.get_action_strength("left")) * speed,0.2)
	
	$flashlight.look_at(get_global_mouse_position())
	
	$ColorRect.scale.x = lerp($ColorRect.scale.x,1.0,0.4)
	if(!is_on_floor()):
		$ColorRect.scale.y = (abs(velocity.y)/2000 + 1.0)
		$ColorRect.scale.x = (-abs(velocity.y)/3000 + 1.0)
	else:
		if(wasinair):
			$ColorRect.scale = Vector2(1.1,0.8)
		$ColorRect.scale.y = lerp($ColorRect.scale.y,1.0,0.4)
	
	$ColorRect.material.set_shader_parameter("skew",-velocity.x / speed * 4)
	
	if(is_on_floor()):
		wasinair = false
	
	move_and_slide()
	
