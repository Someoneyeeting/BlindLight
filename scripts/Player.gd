extends CharacterBody2D



@export var speed :float=30.
@export var grav :float= 9.8
@export var jumpheight :float = 30


func _ready() -> void:
	up_direction = Vector2.UP
	pass
	
func _physics_process(delta: float) -> void:
	if(is_on_floor()):
		if(velocity.y > 0):
			velocity.y = 0
		if(Input.is_action_just_pressed("jump")):
			velocity.y = -jumpheight
			
	velocity.y += grav
	
	velocity.x = lerp(velocity.x,(Input.get_action_strength("right") - Input.get_action_strength("left")) * speed,0.2)
	
	$flashlight.look_at(get_global_mouse_position())
	
	move_and_slide()
	
