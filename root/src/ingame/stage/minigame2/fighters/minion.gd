extends Area2D

onready var animacao = $animation
var target: Vector2
var speed = 100
signal nocateado()

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

var attack = false
var caiu = false
var area_enemy = false

var posLeft: Vector2
var posRight: Vector2
var inital_pos: Vector2

func _ready():
	inital_pos = self.position

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao(_delta)
	
	if($"../../fighter".position.y < -3):
		if(self.name == "minion_center" && $"../../fighter".position.x > -20 && position.x < 20):
			attack = true
		if(self.name == "minion_left" && $"../../fighter".position.x <= -20):
			attack = true
		if(self.name == "minion_right" && $"../../fighter".position.x >= 20):
			attack = true
		
	if !caiu:
		getPos(_delta)
	
func animacao(delta):
	if (Global.tipo_dano != 1 && Global.tipo_dano != 2) && !is_timer_running && !caiu:
		animacao.play("idle")
		
	if (area_enemy):
		if (Global.tipo_dano == 1 || Global.tipo_dano == 2) && !is_timer_running && !caiu:
			animacao.play("desmaio")
			caiu = true
			emit_signal("nocateado")
			

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false

func getPos(delta):	
	var target = Vector2($"../../fighter".position.x, 3)
	if attack:
		
		#faz uma curvinha engraçadinha
		if(self.name == "minion_left"):
			posLeft = self.position
			target.x -= posLeft.x
		if(self.name == "minion_right"):
			posRight = self.position
			target.x -= posRight.x
		
		self.global_position = self.global_position.move_toward(target, delta * speed)
		speed += 1
		if self.global_position.y == target.y:
			$"ataque-delay".start() #trocar por animação
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

func _on_juiz_pegou():
	$EnemySprite.hide()
	$colisao.disabled = true
