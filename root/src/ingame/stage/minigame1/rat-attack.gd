extends Node2D

onready var lblpacotes = $labels/pacotes
onready var lbltiros = $labels/tiros
var _position

var PRE_inimigo = preload("res://src/ingame/stage/minigame1/naves/enemy-ship.tscn").duplicate()

func _physics_process(_delta: float) -> void:
	var tiros_disparados = get_tree().get_nodes_in_group("tiros").size()
	
	lbltiros.set_text(str("tiros: ", 5 - tiros_disparados))
	lblpacotes.set_text(str("pacotes: ", Global.pacotes))
	
	if (Global.pacotes < 0):
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")


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
	get_parent().add_child(inimigo)
	inimigo.position = _position.global_position
	
func _on_Timer_timeout():
	var inimigos = get_tree().get_nodes_in_group("enemies").size()
	print(inimigos)
	if(inimigos < 10):
		invocarRato()
