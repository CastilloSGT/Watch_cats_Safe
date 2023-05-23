extends Area2D

onready var animacao = $animation
var target: Vector2
var speed = 100

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

var attack = false
var caiu = false
var area_enemy = false

var posX = 55
var inital_pos: Vector2

func _ready():
	inital_pos = self.position

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao(_delta)
	
	#if $"../fighter".position.x <= -15 && $"../fighter".position.y < -3:
	#	attack = true
		
	if !caiu:
		getPos(_delta)
	
func animacao(delta):
	if (Global.tipo_dano != 1 && Global.tipo_dano != 2) && !is_timer_running && !caiu:
		animacao.play("idle")
		var direcao = Vector2(posX,-66)
		
		if(self.global_position == direcao):
			self.position.x -= 5
			posX = -posX
		else:
			self.position.x += 5
		
		
	if (area_enemy):
		if (Global.tipo_dano == 1 || Global.tipo_dano == 2) && !is_timer_running && !caiu:
			animacao.play("desmaio")
			caiu = true
			
		if (!is_timer_running && !caiu):
			if(area_enemy):
				print("AAAAAAAAA")
				queue_free()

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false

func getPos(delta):	
	var target = Global.pos_fighter + Vector2(0,-20)
	
	if attack:
		self.global_position = self.global_position.move_toward(target, delta * speed)
		speed += 1
		if self.global_position.y == target.y:
			$"ataque-delay".start()
			caiu = true
	else:
		self.global_position = self.global_position.move_toward(inital_pos, delta * speed)
		speed = 100
	
func _on_ataquedelay_timeout():
	caiu = false
	attack = false

func _on_minion_body_entered(body):
	area_enemy = true

func _on_minion_body_exited(body):
	area_enemy = false
