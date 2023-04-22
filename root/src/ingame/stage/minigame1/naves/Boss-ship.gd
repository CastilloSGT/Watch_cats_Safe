extends Area2D

var life = Global.dano * 50
var dano = 2
var speed = 100
var attack = false

signal boss_killed()

func _physics_process(delta):
	go_forward(delta)

func go_forward(delta):
	var target = $"../ship".global_position
	var inital_pos = $"../posicoes/boss_pos".global_position
	
	if attack:
		self.global_position = self.global_position.move_toward(target, delta * speed)
		speed += 5
	else:
		self.global_position = self.global_position.move_toward(inital_pos, delta * speed)
		speed = 100


func _on_Bossship_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	life -= Global.dano
	if life < 0:
		queue_free()
		emit_signal("boss_killed")

func _on_Bossship_body_entered(body):
	Global.pacotes -= dano
	attack = !attack

func _on_Timer_timeout():
	attack = true