extends Node2D

onready var points = $legendas/lblPoints
onready var _round = $legendas/lblRound
onready var tempo = $legendas/rounds
onready var _modulate = $modulate
onready var status = $"label-colorida"

var PRE_inimigo = preload("res://src/ingame/stage/minigame2/fighters/enemy.tscn").duplicate()
var round_atual = 1

func _ready():
	Global.pos_fighter = $fighters/position.global_position
	tempo.wait_time = 60
	tempo.start()

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

func _process(delta):
	_on_Timer_timeout()
	getRound()
	modulate_check()
	contagem()
	
	var inimigos = get_tree().get_nodes_in_group("enemies").size()
	if (inimigos < round_atual):
		invocarMonkey()

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
			points.hide()
			
func rounds():
	if (Global.pontos_dano > 500 && round_atual == 1 && !is_timer_running):
		round_atual = 2
		waiting()
		
	if (Global.pontos_dano > 1000 && round_atual == 2 && !is_timer_running):
		round_atual = 3
		waiting()
		
	if (Global.pontos_dano > 1500 && round_atual == 3 && !is_timer_running):
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")
	
	
func invocarMonkey():
	var inimigo = PRE_inimigo.instance() #inicia o tiro
	if(tempo.time_left > 3):
		get_parent().add_child(inimigo)
		inimigo.position = $fighters/position.global_position	
	
func contagem():
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	$legendas/lblTimer.set_text(msg)
		
func waiting():
	wait_time = 50
	Global.pontos_dano = 0
	
func modulate_check():
	if(wait_time > 0):
		_modulate.show()
		status.show()
		get_tree().paused = true
	else:
		_modulate.hide()
		status.hide()
		get_tree().paused = false
	
func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false

func _on_tutorial_timer_timeout():
	$tutorial.hide()

func _on_delay_timeout():
	Global.pos_fighter = $fighters/fighter.global_position
