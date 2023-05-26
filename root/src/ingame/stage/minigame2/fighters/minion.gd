extends Area2D

onready var animation = $animation
var target: Vector2
var speed = 100
signal nocateado()

var attack = false
var caiu = false
var area_enemy = false
var ready = false

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

var posLeft: Vector2
var posRight: Vector2
var inital_pos: Vector2

func _ready():
	inital_pos = self.position
	animation.play("idle")
	$"recover-time".start()

func _physics_process(_delta: float) -> void:
	animacao(_delta)
	_on_Timer_timeout()
	
	if(ready):
		if($"../../fighter".position.y < 10):
				if(self.name == "minion_center" && $"../../fighter".position.x > -20 && position.x < 20):
					attack = true
				if(self.name == "minion_left" && $"../../fighter".position.x <= -20):
					attack = true
				if(self.name == "minion_right" && $"../../fighter".position.x >= 20):
					attack = true
	
	if !caiu:
		getPos(_delta)
	
func animacao(delta):
	if (Global.tipo_dano != 1 && Global.tipo_dano != 2) && !caiu && !is_timer_running:
		animation.play("idle")
		
	if (area_enemy):
		if (Global.tipo_dano == 1 || Global.tipo_dano == 2) && !caiu && !is_timer_running:
			animation.play("desmaio")
			caiu = true
			emit_signal("nocateado")
			
func getPos(delta):	
	var target = Vector2($"../../fighter".position.x, 10)
	if attack:
		#nao reseta a animação sla
		if(animation.get_current_animation() ==  'idle'):
			animation.play("atacando") 
			wait_time = 15
		
		if(area_enemy):
			#roda muito mas dboa nao vo criar outro sensor
			Global.vida_fighter -= .5
			
		#faz uma curvinha engraçadinha
		if(self.name == "minion_left"):
			posLeft = self.position
			target.x -= posLeft.x
		if(self.name == "minion_right"):
			posRight = self.position
			target.x -= posRight.x
		
		self.global_position = self.global_position.move_toward(target, delta * speed)
		if self.global_position.y == target.y:
			$"ataque-delay".start()
			caiu = true
	else:
		self.global_position = self.global_position.move_toward(inital_pos, delta * speed)
	
func _on_ataquedelay_timeout():
	animation.play("levantando")
	yield(animation, "animation_finished")
	wait_time = 15
	
	#reset vars
	attack = false
	caiu = false
	$"recover-time".start()
	ready = false

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		Global.tipo_dano = -1
		is_timer_running = false

func _on_recovertime_timeout():
	ready = true

func _on_minion_body_entered(body):
	area_enemy = true

func _on_minion_body_exited(body):
	area_enemy = false

func _on_juiz_pegou():
	$EnemySprite.hide()
	$colisao.disabled = true

func _on_VisibilityNotifier2D_screen_exited():
	$".".queue_free()
