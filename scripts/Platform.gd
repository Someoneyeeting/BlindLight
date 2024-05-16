extends Node2D


@export var target : Node2D
@onready var ogpos := global_position


func _physics_process(delta: float) -> void:
	$RemoteTransform2D.global_position = lerp(ogpos,target.global_position,LevelManger.get_platform_pos())

