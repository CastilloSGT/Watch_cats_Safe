extends Node2D

var velocidade = 130
var sprite_node: Sprite
var sprite_node2: Sprite
var rng: RandomNumberGenerator

func _ready():
	sprite_node = $"0"
	sprite_node2 = $"1"
	rng = RandomNumberGenerator.new()
	start_sequence()

func set_random_sprite():
	var sprite_index = rng.randi_range(0, 1)  
	set_sprite(sprite_index)

func set_sprite(sprite_index: int):
	match sprite_index:
		0:
			sprite_node.visible = true
			sprite_node2.visible = false
		1:
			sprite_node.visible = false
			sprite_node2.visible = true

func start_sequence():
	while true:
		$animation.play("normal")
		while self.position.y < 450:
			self.position.y += velocidade * get_process_delta_time()
			yield(get_tree().create_timer(0.1), "timeout")

		$animation.play("destroi")
		yield($animation, "animation_finished")

		self.position.y = 0
		set_random_sprite()
