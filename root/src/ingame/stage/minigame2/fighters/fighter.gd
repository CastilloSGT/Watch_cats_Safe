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

signal nocateado()

func _ready():
	Global.vida_fighter = vida

func _physics_process(_delta: float) -> void: #roda durante todo nosso jogo
	mexe()
	animacao()
	_on_Timer_timeout()
	
	if(Global.vida_fighter <= 0):
		animacao.play("desmaio")
		emit_signal("nocateado")
		wait_time = 50
	
# move personagem
func mexe() -> void:
	var direcao: Vector2 = Vector2 (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
	 Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	
	if direcao != Vector2.ZERO && !is_timer_running:
		animacao.play("walk")
		velocidade = direcao * speed
		velocidade = move_and_slide(velocidade)
		
	if direcao == Vector2.ZERO && !is_timer_running:
		animacao.play("idle")

func animacao():
	if (Input.is_action_just_pressed("desvia") && !is_timer_running):
		animacao.play("desvio")
		wait_time = 10
		Global.tipo_dano = 0
		
	if (Input.is_action_just_pressed("soco") && !is_timer_running):
		animacao.play("soco")
		wait_time = 10
		Global.tipo_dano = 1
		
	if (Input.is_action_just_pressed("soco-forte") && !is_timer_running):
		animacao.play("soco-forte")
		wait_time = 20
		Global.tipo_dano = 2
		
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
	Global.vida_fighter = vida
