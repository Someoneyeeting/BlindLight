extends Node


signal switchon
var curlevel = 0
var waitingnext = false

func switch_level(level):
	get_tree().change_scene_to_file("res://levels/" + str(level) + ".tscn")

func reload_level():
	switch_level(curlevel)

func next_level():
	curlevel += 1
	switch_level(curlevel)
	LightManger.turn_off()

func _switch_on():
	waitingnext = true
	LightManger.turn_on()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		if(waitingnext):
			next_level()
			waitingnext = false


func _ready() -> void:
	#reload_level()
	switchon.connect(_switch_on)
