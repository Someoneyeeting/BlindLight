extends Node2D
class_name UIButton


signal Press
var selected = false
@export var parentmenu : UIMenu
@export var text : String

func select():
	$AnimationPlayer.play("select")
	parentmenu.manger.get_node("select").play()
	selected = true
	

func _physics_process(delta: float) -> void:
	$Label.text = text
	

func unselect():
	$AnimationPlayer.play("unselect")
	selected = false

func _input(event: InputEvent) -> void:
	if(event.is_action_pressed("ui_accept") and selected and parentmenu.selected and is_visible_in_tree()):
		parentmenu.manger.get_node("press").play()
		Press.emit()
			
func _ready() -> void:
	pass
