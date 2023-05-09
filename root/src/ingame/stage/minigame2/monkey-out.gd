extends Node2D

onready var _round = $legendas/lblRound
onready var tempo = $legendas/rounds
onready var intervalo = $legendas/intervalo

onready var _modulate = $modulate
onready var status = $"label-colorida"

var PRE_inimigo = preload("res://src/ingame/stage/minigame2/fighters/enemy.tscn")

var round_atual = 1
var fim_round = false
var _position

func _ready():
	Global.pos_fighter = $fighters/position.global_position
	tempo.wait_time = 10
	tempo.start()

func _process(delta):
	getRound()
	contagem()
	
	var enemies = get_tree().get_nodes_in_group("enemies")
	if(enemies.size() < round_atual):
		invocaMonkey(round_atual)

func getRound():
	match round_atual:
		1:
			_round.set_text(str("Round 1"))
		2:
			_round.set_text(str("Round 2"))
		3:
			_round.set_text(str("Round 3"))
		0:
			_round.set_text(str("Jogo Finalizado"))
			
func rounds():
	intervalo.start()
	if (round_atual == 3):
		round_atual = 0
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")
	
func contagem():
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	$legendas/lblTimer.set_text(msg)

		
func _on_tutorial_timer_timeout():
	$tutorial.hide()

func invocaMonkey(num):
	var enemies = get_tree().get_nodes_in_group("enemies").size()
	var inimigo = PRE_inimigo.instance()
	
	if(enemies < num):
		get_parent().add_child(inimigo)
		inimigo.position = Global.pos_fighter

func perdeVida():
	$legendas/life.rect_size.x -= 70/10 #tam/(vida/dano) 
	
func _on_delay_timeout():
	Global.pos_fighter = $fighters/fighter.global_position

func _on_rounds_timeout():
	rounds()
	round_atual += 1
	
	print(round_atual)
	
	_modulate.show()
	status.show()
	get_tree().paused = true
	$fighters/fighter.hide()
	
func _on_intervalo_timeout():
	_modulate.hide()
	status.hide()
	$fighters/fighter.show()
	get_tree().paused = false
	invocaMonkey(round_atual)
