extends Area2D
onready var animacao = $animation
var target: Vector2

# TIMER
onready var my_timer = get_node("Timer")
onready var spr_vida = $life

var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor


var vida = 1000;
var speed = 100
var area_enemy = false
var can_attack = false

func _ready():
	can_attack = true

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()
	
	target = Global.pos_fighter + Vector2(0,-20)
	self.global_position = self.global_position.move_toward(target, speed * _delta)
	
func animacao():
	if (Global.tipo_dano == -1 && !is_timer_running):
		animacao.play("idle")
		
	if (area_enemy):
		if (Global.tipo_dano == 1  && !is_timer_running):
			animacao.play("dano")
			wait_time = 10
			vida -= 50
			
		if (Global.tipo_dano == 2 && !is_timer_running):
			animacao.play("soco_mais_forte") #teste
			wait_time = 20
			vida -= 100
			
		if (!is_timer_running && can_attack):
			animacao.play("soco")
			# CRIAR SIGNAL PARA AVISAR QUE DEU SOCO
			wait_time = 10
			can_attack = false
			yield(animacao,"animation_finished")
			$ataque_delay.start()

func perdeVida():
	var tam = vida/35
	print(tam)
	print(vida)

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false


func _on_enemy_body_entered(body):
	area_enemy = true
func _on_enemy_body_exited(body):
	area_enemy = false

func _on_ataque_delay_timeout():
	can_attack = true
