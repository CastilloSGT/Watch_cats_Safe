extends Node2D

onready var _round = $legendas/lblRound
onready var tempo = $legendas/rounds
onready var intervalo = $intervalo
onready var lblround = $"intervalo/label-colorida"

var round_atual = 1
var fim_round = false
var _position

# tempo crescente
var minutes = 0
var seconds = 0
var bonus = 0

signal reset()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	$legendas/vidas/vida_total.rect_size.x = 96
	$legendas/vidas/vida.rect_size.x = 0
	
	$fighters/minions/minion_center.set_physics_process(false)
	$fighters/minions/minion_right.set_physics_process(false)
	$fighters/minions/minion_left.set_physics_process(false)

func _physics_process(_delta: float) -> void:
	contagem()
	mudaPlacar()
	
	if(round_atual < 3):
		_round.set_text(str("Round ",round_atual))
		_round.rect_position.x = 88
	else:
		_round.set_text("Round Final")
		_round.rect_position.x = 74
	
	if($legendas/vidas/vida.rect_size.x > 0):
		bonus = 4 - (96/$legendas/vidas/vida.rect_size.x)
	
	if(bonus >= 2):
		print(true)
		Global.fase_concluida = true
		Global.pontos[1] = int((bonus*100) / (minutes * .15))
	else:
		Global.fase_concluida = false

func rounds():
	$intervalo/intervalo.start()
	round_atual += 1
	if(round_atual == 4):
		$"intervalo/label-colorida".set_bbcode("[wave]Fim de jogo")
		
	intervalo.show()
	get_tree().paused = true

func contagem():
	#se não ele nao respeita o timer de tutorial
	if($tutorial/tutorial_timer.time_left == 0):
		seconds = 60 - tempo.time_left
	var msg = "%02d:%02d" % [minutes, seconds]
	$legendas/lblTimer.set_text(msg)

func mudaPlacar():
	$legendas/life.rect_size.x = Global.vida_fighter/7.15 #500/70 (vida/tam)
	var porcentagem = 500/3
	
	# FIGHTER
	if Global.vida_fighter <= porcentagem:
		$placar/Placar2/animation.play("fighter-KO")
	elif Global.vida_fighter <= porcentagem*2:
		$placar/Placar2/animation.play("fighter-bad")
	else:
		$placar/Placar2/animation.play("fighter-good")

	# ENEMY
	if Global.vida_enemy <= porcentagem:
		$placar/Placar/animation.play("enemy-KO")
	elif Global.vida_enemy <= porcentagem*2:
		$placar/Placar/animation.play("enemy-bad")
	else:
		$placar/Placar/animation.play("enemy-good")

func _on_tutorial_timer_timeout():
	$tutorial.hide()
	tempo.start()
	$fighters/delay.start()

func _on_delay_timeout():
	Global.pos_fighter = $fighters/fighter.global_position

func _on_intervalo_timeout():
	emit_signal("reset")
	mudaPlacar()
	intervalo.hide()
	get_tree().paused = false
	
	if(round_atual == 2):
		$fighters/minions/minion_center.show()
		$fighters/minions/minion_center.set_physics_process(true)
		
	if (round_atual == 3):
		$fighters/minions/minion_right.show()
		$fighters/minions/minion_left.show()
		$fighters/minions/minion_right.set_physics_process(true)
		$fighters/minions/minion_left.set_physics_process(true)
		
	if (round_atual == 4):
		round_atual = 0
		get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")

func _on_fighter_nocateado():
	rounds();
	$legendas/vidas/vida_total.rect_size.x -= 96/3

func _on_enemy_nocateado():
	rounds();
	$legendas/vidas/vida.rect_size.x += 96/3

func _on_rounds_timeout():
	minutes += 1
