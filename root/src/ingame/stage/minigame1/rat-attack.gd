extends Node2D

onready var lblpacotes = $UI/pacotes
onready var tempo = $Timer
onready var lbltempo = $UI/tempo
onready var tiros = $UI/tiros

var PRE_inimigo = preload("res://src/ingame/stage/minigame1/naves/enemy-ship.tscn").duplicate()
var _position

func _ready():
	$"label-colorida".hide()
	$modulate.hide()
	
	get_node("Boss-ship/colisao").disabled = true
	get_node("Boss-ship").hide()
	
	tempo.wait_time = 120
	tempo.start()
	
	var EMITTER = get_node("Boss-ship")
	EMITTER.connect("boss_killed", self, "kill")

func _physics_process(_delta: float) -> void:
	showTiros()
	
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	
	lblpacotes.set_text(str(Global.pacotes))
	lbltempo.set_text(msg)
	
	if (Global.pacotes < 0 ):
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")

func showTiros():
	var tiros_disparados = 5 - get_tree().get_nodes_in_group("tiros").size()
	tiros.rect_size.x = 12 * tiros_disparados 

func getPos():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(1,3)
	match num:
		1:
			_position = $posicoes/pos_1
		2:
			_position = $posicoes/pos_2
		3:
			_position = $posicoes/pos_3
			
func invocarRato():
	getPos()
	var inimigo = PRE_inimigo.instance() #inicia o tiro
	if(tempo.time_left > 3):
		get_parent().add_child(inimigo)
		inimigo.position = _position.global_position
	
func _on_spawnenemy_timeout():
	var inimigos = get_tree().get_nodes_in_group("enemies").size()
	if(inimigos < 10):
		invocarRato()
		
func _on_Timer_timeout():
	tempo.stop()
	lbltempo.hide()
	get_node("Boss-ship").show()
	get_node("Boss-ship/colisao").disabled = false
	get_node("Boss-ship/Timer").start()


# BOSS DERROTADO

func _on_Bossship_boss_killed():
	$"label-colorida".show()
	$modulate.show()
	get_tree().paused = true
