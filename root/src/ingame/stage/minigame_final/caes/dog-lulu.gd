extends Node2D

var _position: Vector2 = Vector2(105,20)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.global_position = self.global_position.move_toward(_position,5.0)
