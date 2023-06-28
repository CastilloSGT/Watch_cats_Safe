
extends Node2D

var velocidade =160
func _ready():
	start_sequence()

func start_sequence():
	while true:
		$animation.play("normal")
		while self.position.y < 100:
			self.position.y += velocidade * get_process_delta_time()
			yield(get_tree().create_timer(0.1), "timeout")
		
		$animation.play("destroi")
		yield($animation, "animation_finished")
		

		self.position.y = 0 
