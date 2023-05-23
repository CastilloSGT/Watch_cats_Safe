extends Node2D

onready var _round = $legendas/lblRound
onready var tempo = $legendas/rounds
onready var intervalo = $intervalo
onready var lblround = $"intervalo/label-colorida"

var round_atual = 1
var fim_round = false
var _position
signal reset()

func _ready():
	$legendas/vidas/vida_total.rect_size.x = 96
	$legendas/vidas/vida.rect_size.x = 0

func _physics_process(_delta: float) -> void:
	contagem()
	perdeVida()
	mudaPlacar()
	_round.set_text(str("Round ",round_atual))

func rounds():
	$intervalo/intervalo.start()
	round_atual += 1
	intervalo.show()
	get_tree().paused = true

func contagem():
	var minutes = tempo.time_left / 60
	var seconds = fmod(tempo.time_left, 60)
	var msg = "%02d:%02d" % [minutes, seconds]
	$legendas/lblTimer.set_text(msg)

func mudaPlacar():
	var porcentagem = 500/3
	
	# FIGHTER
	if Global.vida_fighter <= porcentagem:
		$placar/Placar2/animation.play("fighter-KO")
	elif Global.vida_fighter <= porcentagem*2:
		$placar/Placar2/animation.play("fighter-bad")
	elif Global.vida_fighter >= porcentagem*3:
		$placar/Placar2/animation.play("fighter-good")

	# ENEMY
	if Global.vida_enemy <= porcentagem:
		$placar/Placar/animation.play("enemy-KO")
	elif Global.vida_enemy <= porcentagem*2:
		$placar/Placar/animation.play("enemy-bad")
	elif Global.vida_enemy >= porcentagem*3:
		$placar/Placar/animation.play("enemy-good")


func _on_tutorial_timer_timeout():
	$tutorial.hide()
	tempo.start()
	$fighters/delay.start()

func perdeVida():
	$legendas/life.rect_size.x = Global.vida_fighter/7.15 #500/70 (vida/tam)
	
func _on_delay_timeout():
	Global.pos_fighter = $fighters/fighter.global_position

func _on_intervalo_timeout():
	emit_signal("reset")
	mudaPlacar()
	intervalo.hide()
	get_tree().paused = false
	
	if (round_atual == 4):
		round_atual = 0
		get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")

func _on_fighter_nocateado():
	rounds();
	$legendas/vidas/vida_total.rect_size.x -= 96/3

func _on_enemy_nocateado():
	rounds();
	$legendas/vidas/vida.rect_size.x += 96/3
