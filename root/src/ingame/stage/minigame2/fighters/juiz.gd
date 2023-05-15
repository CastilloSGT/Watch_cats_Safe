extends Area2D

var target
var initial_pos = Vector2(300,-5)
onready var animacao = $animation

var caiu = false
signal pegou()

func _ready():
	animacao.play("walk")
	
	var EMITTER = get_node("../enemy")
	EMITTER.connect("nocateado", self, "nocateado")

func _process(delta):
	if(caiu):
		target = Global.pos_enemy
		if(self.global_position == target):
			animacao.play("idle")
			yield(animacao,"animation_finished")
		
			animacao.play("leavin")
			$Juiz.set_flip_h(true)
		
			Global.pos_enemy = initial_pos
			emit_signal("pegou")
		else:
			self.global_position = self.global_position.move_toward(target, 30 * delta)
	else:
		Global.pos_enemy = Vector2(190,-5)

func _on_enemy_nocateado():
	caiu = true
