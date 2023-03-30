extends KinematicBody2D
onready var animacao = $animation

# TIMER
onready var my_timer = get_node("Timer")

var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()
	rounds()
	
func animacao():
	if (Global.tipo_dano == -1 && !is_timer_running):
		animacao.play("idle")
	
	if (Global.area_enemy == true):
		if (Global.tipo_dano == 1  && !is_timer_running):
			animacao.play("dano")
			wait_time = 10
			Global.pontos_dano += 50
			
		if (Global.tipo_dano == 2 && !is_timer_running):
			animacao.play("soco_mais_forte") #teste
			wait_time = 20
			Global.pontos_dano += 100
				
func rounds():
	if (Global.pontos_dano == 500 && Global.round_atual == 1 && !is_timer_running):
		wait_time = 50
		Global.round_atual = 2
		Global.pontos_dano = 0
		
	if (Global.pontos_dano == 1000 && Global.round_atual == 2 && !is_timer_running):
		wait_time = 50
		Global.round_atual = 3
		Global.pontos_dano = 0
		
	if (Global.pontos_dano == 1500 && Global.round_atual == 3 && !is_timer_running):
		wait_time = 50
		Global.round_atual = 0
		Global.pontos_dano = 0

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false

