extends Node2D

func _ready() -> void:
	if Global.lugar != null:
		get_node("player").set_position(get_node(Global.lugar + "pos").position)

