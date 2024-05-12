extends Node


signal switchon
signal restart
var curlevel = 0
var waitingnext = false

func switch_level(level):
	get_tree().change_scene_to_file("res://levels/" + str(level) + ".tscn")
	$off.play()


func darken():
	$ColorRect.show()
	$on.play()

func reload_level():
	if($restart.time_left <= 0):
		darken()
		darken()
		$restart.start()

func next_level():
	curlevel += 1
	switch_level(curlevel)
	LightManger.turn_off()

func _switch_on():
	waitingnext = true
	$on.play()
	LightManger.turn_on()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		if(waitingnext):
			next_level()
			waitingnext = false


func _ready() -> void:
	#reload_level()
	switchon.connect(_switch_on)
	restart.connect(reload_level)


func _on_restart_timeout() -> void:
	$ColorRect.hide()
	switch_level(curlevel)
