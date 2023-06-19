extends Node2D

func _ready():
	$animation.play("open")
	yield($animation, "animation_finished")
	$animation.play("close")
