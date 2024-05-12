extends Node


var player : CharacterBody2D
var background : Sprite2D
var light := false
var onlight = []


func clearlights():
	onlight.clear()

func _ready() -> void:
	LevelManger.switchon.connect(clearlights)

func turn_on():
	light = true
	player.queue_free()
	player = null
	background.material.set_shader_parameter("lighton",true)
	for i in get_tree().get_nodes_in_group("light"):
		i.queue_free()

func turn_off():
	light = false
	background.material.set_shader_parameter("lighton",false)
	onlight.clear()

func switch():
	if(light):
		turn_off()
	else:
		turn_on()
#func _physics_process(delta: float) -> void:
	#if(ligh)
