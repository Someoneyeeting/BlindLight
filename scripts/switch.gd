extends Node2D



func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body is CharacterBody2D):
		LevelManger.switchon.emit()
		hide()
