extends Area2D

onready var animacao = $animation
onready var spr_vida = $life
var target: Vector2

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

var caiu = false
var i = 0

var vida = 100
var area_enemy = false
var can_attack = true

signal nocateado()

func _ready():
	spr_vida.rect_size.x = 35
	Global.vida_enemy += vida
	
	var EMITTER = get_node("../juiz")
	EMITTER.connect("pegou", self, "pegou")

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()
	
	if (Global.vida_enemy <= 0):
		if(!caiu):
			animacao.play("desmaio")
			yield(animacao,"animation_finished")
			caiu = true
			nocaute()
	else:
		getPos(_delta)
	
func animacao():
	if (Global.tipo_dano == -1 && !is_timer_running && !caiu):
		animacao.play("idle")
		
	if (area_enemy):
		if (Global.tipo_dano == 1  && !is_timer_running && !caiu):
			animacao.play("dano")
			wait_time = 10
			Global.vida_enemy -= 50
			spr_vida.rect_size.x -= 35/(vida/100) #tam/(vida/dano) 
			
		if (Global.tipo_dano == 2 && !is_timer_running && !caiu):
			animacao.play("dano_mais_forte") #teste
			wait_time = 20
			Global.vida_enemy -= 100
			spr_vida.rect_size.x -= 35/((vida/100)*2) #tam/(vida/dano) 
		
		if (!is_timer_running && can_attack && !caiu):
			animacao.play("soco")
			wait_time = 10
			can_attack = false
			yield(animacao,"animation_finished")
			
			if(Global.tipo_dano != 0 && area_enemy):
				Global.vida_fighter -= 100
				
			$ataque_delay.start()

func nocaute():
	$colisao.disabled = true
	animacao.play("tentando")
	$nocaute.start()

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false

func getPos(_delta):
	target = Global.pos_fighter + Vector2(0,-20)
	var enemies = get_tree().get_nodes_in_group("enemies")
	var first = enemies[0].get_instance_id()
	
	if(enemies.size() > 0):
		enemies[0].global_position = enemies[0].global_position.move_toward(target, 50 * _delta)
		
	if(enemies.size() > 1):
		enemies[1].global_position = enemies[1].global_position.move_toward(target+Vector2(-25,10), 30 * _delta)
		
	if(enemies.size() > 2):
		enemies[2].global_position = enemies[2].global_position.move_toward(target+Vector2(25,10), 60 * _delta)

func _on_enemy_body_entered(body):
	area_enemy = true

func _on_enemy_body_exited(body):
	area_enemy = false

func _on_ataque_delay_timeout():
	can_attack = true

func _on_juiz_pegou():
	$".".hide()

func _on_VisibilityNotifier2D_screen_exited():
	$"..".queue_free()

func _on_nocaute_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1,5)
	print(i)
	
	if(num == 1):
		$colisao.disabled = false
		animacao.play("recuperado")
		yield(animacao,"animation_finished")
		
		Global.vida_enemy += vida/20
		spr_vida.rect_size.x -= 35/(vida/100)
		
		caiu = false
	else:
		$nocaute.start()
		i += 1
		
	if(i == 3):
		$colisao.disabled = true
		animacao.play("caido")
		emit_signal("nocateado")
		Global.pos_enemy = self.global_position + Vector2(0,10)
		$"../juiz".show()
		
