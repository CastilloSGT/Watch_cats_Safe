extends Area2D

var dano = 2
var speed = 100
var attack = false
var getHit = false

onready var life = $"../life"
var allLife 

onready var animation = $AnimationPlayer
onready var player_anim = $"../../ship/AnimationPlayer"

signal boss_killed()
signal player_killed()

func _ready():
	animation.play("idle")
	Global.Boss_life = Global.dano * 50
	#BARRA DE VIDA
	life.rect_size.x = 184

func _physics_process(delta):
	if(Global.pacotes > 0):
		go_forward(delta)

func go_forward(delta):
	var target = $"../../ship".global_position
	var inital_pos = $"../../posicoes/boss_pos".global_position
	
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
	
	life.rect_size.x -= 3.65
	Global.Boss_life -= Global.dano
	
	if Global.Boss_life < 0:
		animation.play("dead")
		get_tree().paused = true
		yield(animation,"animation_finished")
		emit_signal("boss_killed")
		queue_free()

func _on_Bossship_body_entered(body):
	getHit = false
	attackOrPain()
	player_anim.play("hit")
	
	Global.pacotes -= dano
	attack = !attack
	
	if (Global.pacotes <= 0 ):
		player_anim.play("dead")
		yield(player_anim,"animation_finished")
		$"../../ship".queue_free()
		emit_signal("player_killed")
		animation.play("win")

func _on_Timer_timeout():
	attack = true
