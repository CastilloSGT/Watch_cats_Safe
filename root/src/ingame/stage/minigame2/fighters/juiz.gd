extends Area2D

var target
var initial_pos = Vector2(300,-5)
onready var animacao = $animation

var caiu = false
var pego = false
signal pegou()

func _ready():
	animacao.play("walk")

func _process(delta):
	if(caiu):
		if(!pego):
			target = $"..".position
		if(self.global_position == target):
			animacao.play("idle")
			yield(animacao,"animation_finished")
		
			animacao.play("leavin")
			$Juiz.set_flip_h(true)
			emit_signal("pegou")
			
			pego = true
			target = initial_pos
		else:
			self.global_position = self.global_position.move_toward(target, 65 * delta)
	else:
		self.global_position = Vector2(190,-5)

func _on_minion_nocateado():
	caiu = true
