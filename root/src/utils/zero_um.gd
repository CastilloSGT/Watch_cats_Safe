extends Node2D

func _ready():
	$animation.play("normal")

func _process(delta):
	self.position.y += 1;
	
	if(self.position.y == 50):
		$animation.play("destroi")
		yield($animation, "animation_finished")
		queue_free()
