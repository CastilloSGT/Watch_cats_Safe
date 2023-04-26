extends Area2D

var life = Global.dano * 50
var dano = 2
var speed = 100
var attack = false
var getHit = false

onready var animation = $AnimationPlayer

signal boss_killed()
signal player_killed()

func _ready():
	animation.play("idle")

func _physics_process(delta):
	go_forward(delta)

func go_forward(delta):
	var target = $"../ship".global_position
	var inital_pos = $"../posicoes/boss_pos".global_position
	
	if attack:
		attackOrPain()
		self.global_position = self.global_position.move_toward(target, delta * speed)
		speed += 5
	else:
		self.global_position = self.global_position.move_toward(inital_pos, delta * speed)
		speed = 100

func attackOrPain():
	if(getHit):
		animation.play("pain")
	else:
		animation.play("attack")
		
	yield(animation,"animation_finished")
	getHit = false
	animation.play("idle")

func _on_Bossship_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	getHit = true
	attackOrPain()
	
	life -= Global.dano
	
	if life < 0:
		queue_free()
		emit_signal("boss_killed")

func _on_Bossship_body_entered(body):
	getHit = false
	attackOrPain()
	
	Global.pacotes -= dano
	attack = !attack
	
	if (Global.pacotes < 0 ):
		emit_signal("player_killed")

func _on_Timer_timeout():
	attack = true
