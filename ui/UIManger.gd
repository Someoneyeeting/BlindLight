extends Node2D
class_name UIManger

var curmenu
var menus = {
	"main" : preload("res://ui/main_menu.tscn"),
	"settings" : preload("res://ui/settings.tscn"),
	"quit" : preload("res://ui/quitgame.tscn")
}
@onready var initmenu := "main"

func _ready() -> void:
	open_menu(initmenu)

func open_menu(menu):
	var men = menus[menu].instantiate()
	if($menus.get_child_count() > 0):
		$menus.get_children().back().selected = false
		$menus.get_children().back().hide()
	men.selected = true
	men.manger = self
	$menus.add_child(men)
	

func close_current():
	print($menus.get_children().back().name)
	$menus.get_children().back().killyourself()
	print($menus.get_children().back().name)
	$menus.get_children()[-1].set_deferred("selected",true)
	#$menus.get_children()[.].show()
	
func close_menu():
	queue_free()
