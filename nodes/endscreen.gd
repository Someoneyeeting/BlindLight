extends Node2D


var curslide = 0

#func _ready() -> void:
	#

func _on_timer_timeout() -> void:
	if(curslide >= 4):
		LevelManger.main_menu()
		return
	get_node(str(curslide)).show()
	if(curslide > 0):
		get_node(str(curslide - 1)).hide()
	curslide += 1
	$switch.play()
