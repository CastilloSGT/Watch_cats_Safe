extends Node2D

var speed = 5

func _process(delta):
	self.position.y -= delta * speed
