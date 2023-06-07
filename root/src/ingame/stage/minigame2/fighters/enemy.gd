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
signal nocateado()

var vida = 500
var area_enemy = false
var can_attack = true

func _ready():
	spr_vida.rect_size.x = 35
	Global.vida_enemy = vida
	Global.pos_enemy = self.global_position + Vector2(0,10)
	Global.pos_fighter = self.global_position
	$ataque_delay.start()

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()
	
	if (Global.vida_enemy  <= 0):
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
			perde_vida(50)
			
		if (Global.tipo_dano == 2 && !is_timer_running && !caiu):
			animacao.play("dano_mais_forte") #teste
			wait_time = 20
			perde_vida(100)
		
		if (!is_timer_running && can_attack && !caiu):
			wait_time = 10
			can_attack = false
			animacao.play("soco")
			yield(animacao,"animation_finished")
			ataque()
			$ataque_delay.start()

func nocaute():
	$colisao.disabled = true
	animacao.play("tentando")
	$nocaute.start()

func ataque():
	if(Global.tipo_dano != 0 && area_enemy && !caiu):
		Global.vida_fighter -= 100

func perde_vida(dano):
	Global.vida_enemy -= dano
	spr_vida.rect_size.x = Global.vida_enemy/14.3 #500/35 (vida/tam)

func ganha_vida(full_life):
	$lblNocaute.hide()
	i = 0
	animacao.play("recuperado")
	yield(animacao,"animation_finished")
	animacao.play("idle")
	$colisao.disabled = false
	caiu = false
	
	if(full_life):
		Global.vida_enemy = vida
		spr_vida.rect_size.x = 35
	else:
		Global.vida_enemy = vida/2
		spr_vida.rect_size.x = 35/2

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
	self.global_position = self.global_position.move_toward(target, 50 * _delta)
	
func _on_enemy_body_entered(body):
	area_enemy = true
func _on_enemy_body_exited(body):
	area_enemy = false

func _on_ataque_delay_timeout():
	can_attack = true

func _on_nocaute_timeout():
	$ataque_delay.start()
	
	$lblNocaute.show()
	$lblNocaute.set_text(str(3-i))
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0,3)
	
	if(num == 1):
		ganha_vida(false)
	else:
		$nocaute.start()
		i += 1
		
	if(i == 4):
		$colisao.disabled = true
		$nocaute.stop()
		$lblNocaute.hide()
		animacao.play("caido")
		yield(animacao,"animation_finished")
		emit_signal("nocateado")

func _on_monkeyout_reset():
	ganha_vida(true)
