extends Node2D



func lighton():
	LightManger.turn_on()
	$level.queue_free()
	$block.show()
	


func lightoff():
	LevelManger.darken()


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	lightoff()

func _on_area_2d_body_entered(body: Node2D) -> void:
	$AnimationPlayer.play("tidalwaave")
