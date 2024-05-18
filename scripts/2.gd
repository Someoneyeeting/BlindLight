extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
	$trap.set_collision_layer_value(1,true)
	$trap/block25.set_collision_layer_value(1,true)
	$trap.show()
