@tool
extends Node2D



@export var off = 0.035


func _ready() -> void:
	$back.material = $back.material.duplicate()

func _physics_ocess(delta: float) -> void:
	$back.material.set_shader_parameter("off",off)
	
