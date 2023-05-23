extends KinematicBody2D
# VARIAVEIS
var vida = 500
var velocidade: Vector2
var speed = 60 #var para mover personagem
onready var animacao = $animation

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

var caiu = false
signal nocateado()

func _ready():
	Global.vida_fighter = vida
	$nocaute/nocauteBar.rect_size.x = 0

func _physics_process(_delta: float) -> void: #roda durante todo nosso jogo
	mexe()
	animacao()
	_on_Timer_timeout()
	
	if(Global.vida_fighter <= 0 && !caiu):
		animacao.play("desmaio")
		$colisao.disabled = true
		
		$tutorial/lbltutorial.show()
		$tutorial/tutorial.start()
		$nocaute/lblNocaute.show()
		
		caiu = true
		$nocaute/nocaute.start()
		
	if(caiu):
		nocaute()
	
# move personagem
func mexe() -> void:
	var direcao: Vector2 = Vector2 (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	 Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	
	if direcao != Vector2.ZERO && !is_timer_running && !caiu:
		animacao.play("walk")
		velocidade = direcao * speed
		velocidade = move_and_slide(velocidade)
		
	if direcao == Vector2.ZERO && !is_timer_running && !caiu:
		animacao.play("idle")

func animacao():
	if (Input.is_action_just_pressed("desvia") && !is_timer_running && !caiu):
		animacao.play("desvio")
		wait_time = 15
		Global.tipo_dano = 0
		
	if (Input.is_action_just_pressed("soco") && !is_timer_running && !caiu):
		animacao.play("soco")
		wait_time = 10
		Global.tipo_dano = 1
		
	if (Input.is_action_just_pressed("soco-forte") && !is_timer_running && !caiu):
		animacao.play("soco-forte")
		wait_time = 20
		Global.tipo_dano = 2

func nocaute():
	$nocaute/lblNocaute.set_text("%02d" % [fmod($nocaute/nocaute.time_left, 60)])
	
	if Input.is_action_just_pressed("soco"):
		$nocaute/nocauteBar.rect_size.x += 4
		
	if($nocaute/nocauteBar.rect_size.x == 40):
		$nocaute/nocaute.stop()
		$nocaute/nocauteBar.rect_size.x = 0
		ganha_vida(false)

func ganha_vida(full_life):
	$nocaute/lblNocaute.hide()
	$nocaute/nocauteBar.rect_size.x = 0
	animacao.play("recuperado")
	yield(animacao,"animation_finished")
	$colisao.disabled = false
	caiu = false
	
	if(full_life):
		Global.vida_fighter = vida
	else:
		Global.vida_fighter = vida/2

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		Global.tipo_dano = -1
		is_timer_running = false

func _on_monkeyout_reset():
	ganha_vida(true)

func _on_nocaute_timeout():
	$nocaute/lblNocaute.hide()
	animacao.play("caido")
	yield(animacao,"animation_finished")
	emit_signal("nocateado")

func _on_tutorial_timeout():
	$tutorial/lbltutorial.hide()
