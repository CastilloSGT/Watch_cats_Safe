extends Area2D

onready var animacao = $animation
onready var spr_vida = $life
var target: Vector2

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

var vida = 500
var caiu = false
var area_enemy = false
var can_attack = true

signal enemy_killed()

func _ready():
	spr_vida.rect_size.x = 35
	Global.vida_enemy += vida

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()
	
	#DEFINIR CAIU COMO UMA GLOBAL PARA O JUIZ APARECER E CONTAR
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
			spr_vida.rect_size.x -= 35/10 #tam/(vida/dano) 
			
		if (Global.tipo_dano == 2 && !is_timer_running && !caiu):
			animacao.play("dano_mais_forte") #teste
			wait_time = 20
			Global.vida_enemy -= 100
			spr_vida.rect_size.x -= 35/5 #tam/(vida/dano) 
		
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
	animacao.play("caido")
	wait_time = 50
	#yield(animacao,"animation_finished")
	
	#COLOCAR TIMER QUE EXECUTA 3 VEZES (3 SEGUNDOS) E MORRE
	#animacao.play("tentando")
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0,1)
	
	if(num == 0):
		animacao.play("caido")
	else:
		animacao.play("recuperado")
		yield(animacao,"animation_finished")
		$colisao.disabled = false
		animacao.play("idle")

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
