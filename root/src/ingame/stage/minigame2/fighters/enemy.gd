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

var vida_fixo = 100
var vida = vida_fixo
var area_enemy = false
var can_attack = true

signal nocateado()

func _ready():
	spr_vida.rect_size.x = 35
	Global.vida_enemy += vida_fixo
	Global.pos_enemy = self.global_position + Vector2(0,10)
	
	var EMITTER = get_node("../juiz")
	EMITTER.connect("pegou", self, "pegou")

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()
	
	if (vida <= 0):
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

func perde_vida(dano):
	Global.vida_fighter -= dano
	vida -= dano
	spr_vida.rect_size.x -= 35/(vida_fixo/dano) #tam/(vida/dano) 

func ganha_vida():
	vida = vida_fixo/2
	spr_vida.rect_size.x = 35/(vida_fixo/50)

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
	
	if(get_parent().name == "enemy_1"):
		self.global_position = self.global_position.move_toward(target, 50 * _delta)
	if(get_parent().name == "enemy_2"):
		self.global_position = self.global_position.move_toward(target+Vector2(25,10), 60 * _delta)
	if(get_parent().name == "enemy_3"):
		self.global_position = self.global_position.move_toward(target+Vector2(-25,10), 40 * _delta)

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
	$lblNocaute.show()
	$lblNocaute.set_text(str(3-i))
	
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0,3)
	
	if(num == 1):
		$lblNocaute.hide()
		i = 0
		animacao.play("recuperado")
		yield(animacao,"animation_finished")
		
		ganha_vida()
		$colisao.disabled = false
		caiu = false
	else:
		$nocaute.start()
		i += 1
		
	if(i == 4):
		$colisao.disabled = true
		$nocaute.stop()
		$lblNocaute.hide()
		
		animacao.play("caido")
		emit_signal("nocateado")
		
		$"../juiz".show()
