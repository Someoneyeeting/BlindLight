extends Node


signal switchon
signal restart
var curlevel = 0
var waitingnext = false
var platformdir = false
var playing = false
var levels = [
	"res://levels/intro.tscn",
	"res://levels/jump.tscn",
	"res://levels/parkour.tscn",
	"res://levels/troll.tscn",
	"res://levels/blindjump.tscn",
	"res://levels/platform.tscn",
	"res://levels/complex.tscn",
	"res://levels/beforetheend.tscn",
	"res://levels/endscreen.tscn"
]

var platformlevels = [
	"res://levels/platform.tscn",
	"res://levels/complex.tscn"
]

func switch_level(level):
	get_tree().call_deferred("change_scene_to_file",levels[level])
	if(not get_tree().paused):
		$off.play()
		$noise.stream_paused = false
	if(levels[curlevel] in platformlevels):
		$platformtimer.start()
	else:
		$platformtimer.stop()
		$platformcooldown.stop()
		$leverpull.stop()
		$stop.stop()
		$platform.stop()
	


func get_platform_pos():
	if(platformdir):
		return 1 - $platformtimer.time_left/$platformtimer.wait_time
	else:
		return $platformtimer.time_left/$platformtimer.wait_time
		

func darken():
	$ColorRect.show()
	$noise.stream_paused = true
	get_tree().current_scene.queue_free()
	$on.play()

func reload_level():
	if($restart.time_left <= 0):
		darken()
		$restart.start()

func next_level():
	curlevel += 1
	$CanvasLayer/ColorRect.material.set_shader_parameter("intense",3.0)
	switch_level(curlevel)
	LightManger.turn_off()

func _switch_on():
	waitingnext = true
	$CanvasLayer/ColorRect.material.set_shader_parameter("intense",2.0)
	$on.play()
	$noise.stream_paused = true
	LightManger.turn_on()

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept")):
		if(waitingnext):
			next_level()
			waitingnext = false
	if(event.is_action_pressed("fullscreen")):
		if(DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if(event.is_action_pressed("pause")):
		if(playing and curlevel < levels.size() - 1):
			if(get_tree().paused):
				unpause()
			else:
				pause()


func _ready() -> void:
	reload_level()
	
	get_tree().paused = true
	#$ui.show()
	
	switchon.connect(_switch_on)
	restart.connect(reload_level)
	$noise.stream_paused = true
	#$CanvasLayer/ColorRect.material.set_shader_parameter("web","web" in OS.get_name().to_lower())
	
	preload("res://levels/intro.tscn")
	preload("res://levels/jump.tscn")
	preload("res://levels/parkour.tscn")
	preload("res://levels/troll.tscn")
	preload("res://levels/blindjump.tscn")
	preload("res://levels/platform.tscn")
	preload("res://levels/complex.tscn")
	preload("res://levels/beforetheend.tscn")
	preload("res://levels/endscreen.tscn")


func start_play():
	unpause()
	$ui/StartScreen.hide()
	$ui/pause.show()
	reload_level()
	playing = true

func main_menu():
	curlevel = 0
	reload_level()
	$ui.show()
	$ui/pause.hide()
	$ui/StartScreen.show()
	get_tree().paused = true
	playing = false
	$noise.stream_paused = true

func _on_restart_timeout() -> void:
	$ColorRect.hide()
	switch_level(curlevel)


func _on_platformtimer_timeout() -> void:
	$platformcooldown.start()
	$stop.play()
	await get_tree().create_timer(0.5).timeout
	$platform.stop()


func _on_platformcooldown_timeout() -> void:
	$leverpull.play()
	await get_tree().create_timer(0.7).timeout
	$platform.play()
	platformdir = not platformdir
	$platformtimer.start()

func pause():
	$ui.show()
	await get_tree().create_timer(0.1).timeout
	get_tree().set_deferred("paused",true)

func unpause():
	$ui.hide()
	await get_tree().create_timer(0.1).timeout
	get_tree().set_deferred("paused",false)
	
	

func _on_levelpull_finished() -> void:
	pass
