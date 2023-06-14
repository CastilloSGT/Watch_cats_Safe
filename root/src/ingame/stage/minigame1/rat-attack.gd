extends Node2D

onready var transition = get_node("transicao_foda/animation")
onready var lblpacotes = $UI/pacotes
onready var tempo = $timers/Timer
onready var lbltempo = $UI/tempo
onready var tiros = $UI/tiros

var PRE_inimigo = preload("res://src/ingame/stage/minigame1/naves/enemy-ship.tscn").duplicate()
var _position

func _ready():
	$transicao_foda.show()
	transition.play("out")
	
	$"label-colorida".hide()
	$modulate.hide()
	get_node("boss/Boss-ship/colisao").disabled = true
	$boss.hide()

	tempo.wait_time = 60
	tempo.start()
	
	var EMITTER = get_node("boss/Boss-ship")
	EMITTER.connect("boss_killed", self, "kill")
	EMITTER.connect("player_killed", self, "kill")

func _physics_process(_delta: float) -> void:
	showTiros()
	
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	
	lblpacotes.set_text(str(Global.pacotes))
	lbltempo.set_text(msg)

func showTiros():
	var tiros_disparados = 5 - get_tree().get_nodes_in_group("tiros").size()
	tiros.rect_size.x = 12 * tiros_disparados 

func getPos():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(4,6)
	match num:
		1:
			_position = $posicoes/pos_1
		2:
			_position = $posicoes/pos_2
		3:
			_position = $posicoes/pos_3
		4:
			_position = $posicoes/pos_4
		5:
			_position = $posicoes/pos_5
		6:
			_position = $posicoes/pos_6
			
func invocarRato():
	getPos()
	var inimigo = PRE_inimigo.instance()
	if(tempo.time_left > 3):
		get_parent().add_child(inimigo)
		inimigo.position = _position.global_position

func gameOver():
	$"label-colorida".show()
	$modulate.show()
	#força a morte das instancias
	var inimigos = get_tree().get_nodes_in_group("enemies")
	for inimigo in inimigos:
		inimigo.queue_free()
		
	var tiros = get_tree().get_nodes_in_group("tiros")
	for tiro in tiros:
		tiro.queue_free()
	
	get_tree().paused = true
	$timers/gameOver.start()

func _on_spawnenemy_timeout():
	var inimigos = get_tree().get_nodes_in_group("enemies").size()
	if(inimigos < 10):
		invocarRato()
		
func _on_Timer_timeout():
	tempo.stop()
	lbltempo.hide()
	
	if(Global.pacotes <= 0):
		$"label-colorida".set_bbcode("[wave]VOCÊ PERDEU")
		gameOver()
	else:
		$boss.show()
		get_node("boss/Boss-ship/colisao").disabled = false
		get_node("boss/Boss-ship/Timer").start()

# BOSS DERROTADO
func _on_Bossship_boss_killed():
	$"label-colorida".set_bbcode("[wave]VOCÊ GANHOU")
	Global.pontos[0] = int(Global.pacotes * 10)
	Global.fase_concluida = true
	gameOver()
	
func _on_Bossship_player_killed():
	$"label-colorida".set_bbcode("[wave]VOCÊ PERDEU")
	Global.fase_concluida = false
	gameOver()	

func _on_gameOver_timeout():
	get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")
	get_tree().paused = false

func _on_tutorial_timeout():
	$UI/tutorial.hide()
