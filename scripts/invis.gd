extends Node2D





func _on_area_2d_area_entered(area: Area2D) -> void:
	if(area.is_in_group("flashlight")):
		$StaticBody2D/CollisionShape2D.set_deferred("disabled",true)


func _on_area_2d_area_exited(area: Area2D) -> void:
	if(area.is_in_group("flashlight")):
		$StaticBody2D/CollisionShape2D.set_deferred("disabled",false)
