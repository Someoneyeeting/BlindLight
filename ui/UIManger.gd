extends Node2D
class_name UIManger

var curmenu
var menus = {
	"main" : preload("res://ui/main_menu.tscn"),
	"settings" : preload("res://ui/settings.tscn"),
	"quit" : preload("res://ui/quitgame.tscn"),
	"pause" : preload("res://ui/pause.tscn"),
	"exit" : preload("res://nodes/exit.tscn"),
	"howtoplay" : preload("res://nodes/howtoplay.tscn")
}
@export var startmenu := true

func _ready() -> void:
	if(startmenu):
		open_menu("main")
	else:
		open_menu("pause")

func open_menu(menu):
	var men = menus[menu].instantiate()
	if($menus.get_child_count() > 0):
		$menus.get_children().back().selected = false
		$menus.get_children().back().hide()
	men.selected = true
	men.manger = self
	$menus.add_child(men)
	

func close_current():
	$menus.get_children().back().killyourself()
	$menus.get_children()[-1].set_deferred("selected",true)
	#$menus.get_children()[.].show()
	
func close_menu():
	get_parent().remove_child(self)
	queue_free()
