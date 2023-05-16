extends Node2D

onready var _round = $legendas/lblRound
onready var tempo = $legendas/rounds
onready var intervalo = $intervalo
onready var lblround = $"intervalo/label-colorida"

var round_atual = 1
var fim_round = false
var _position

func _process(delta):
	contagem()
	_round.set_text(str("Round ",round_atual))

func rounds():
	$intervalo/intervalo.start()
	
	if(Global.vida_enemy > Global.vida_fighter):
		print("enemi")
	if(Global.vida_fighter > Global.vida_enemy):
		print("voce")
	if(Global.vida_enemy == Global.vida_fighter):
		print("empate")
	
	if (round_atual == 5):
		round_atual = 0
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")
	
func contagem():
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	$legendas/lblTimer.set_text(msg)

func _on_tutorial_timer_timeout():
	$tutorial.hide()
	#aparece 1 ou dois monkey
	tempo.start()
	$fighters/delay.start()


func perdeVida():
	$legendas/life.rect_size.x -= 70/10 #tam/(vida/dano) 
	
func _on_delay_timeout():
	Global.pos_fighter = $fighters/fighter.global_position

func _on_rounds_timeout():
	rounds()
	round_atual += 1
	intervalo.show()
	get_tree().paused = true
	
func _on_intervalo_timeout():
	intervalo.hide()
	get_tree().paused = false
