extends Area2D
var target: Vector2
var speed = 50

func _ready():
	target = $"../../fighter".position
	
func _process(delta):
	self.global_position = self.global_position.move_toward(target, delta * speed)

func _on_banana_body_entered(body):
	Global.BANANA_ATTACK = true
	Global.vida_fighter -= 5
	queue_free()
