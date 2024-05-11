extends Node


var player : CharacterBody2D
var background : Sprite2D
var light := false
var onlight = []


func turn_on():
	light = true
	player.hide()
	background.material.set_shader_parameter("lighton",true)
	for i in get_tree().get_nodes_in_group("light"):
		if(i.visible):
			onlight.append(i)
			i.hide()

func turn_off():
	light = false
	player.show()
	background.material.set_shader_parameter("lighton",false)
	
	for i in onlight:
		i.show()
	
	onlight.clear()

func switch():
	if(light):
		turn_off()
	else:
		turn_on()
#func _physics_process(delta: float) -> void:
	#if(ligh)
