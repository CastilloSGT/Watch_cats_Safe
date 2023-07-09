extends Node2D

func _ready():
	$animation.play("close")
	yield($animation, "animation_finished")
	queue_free()
