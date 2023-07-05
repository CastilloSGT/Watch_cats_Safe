extends Node2D

var position_subida: Position2D
var position_descida: Position2D
var velocidade = 100
var animation: AnimationPlayer

func _ready():
	position_subida = get_node("/root/GlobalCanvasLayer/Control/Node2D/position2D")
	position_descida = get_node("/root/GlobalCanvasLayer/Control/Node2D/positeste")
	animation = $animation
	start_sequence()

func start_sequence():
	while true:
		animation.play("normal")

		while position_subida.position.y > 130 or position_descida.position.y < 300:
			if position_subida.position.y > 130:
				position_subida.position.y -= velocidade * get_process_delta_time()
			if position_descida.position.y < 300:
				position_descida.position.y += velocidade * get_process_delta_time()
			yield(get_tree().create_timer(0.1), "timeout")

		animation.play("destroi")
		yield(animation, "animation_finished")

		position_subida.position.y = 300
		position_descida.position.y = 130

