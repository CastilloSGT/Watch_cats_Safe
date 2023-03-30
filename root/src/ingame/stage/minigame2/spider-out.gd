extends Node2D

onready var points = $lblPoints
onready var _round = $lblRound

func _process(delta):
	points.set_text(str("Pontos:", Global.pontos_dano))
	print(Global.round_atual)
	getRound()

func getRound():
	match Global.round_atual:
		1:
			_round.set_text(str("Round 1"))
		2:
			_round.set_text(str("Round 2"))
		3:
			_round.set_text(str("Round 3"))
		0:
			_round.set_text(str("Jogo Finalizado"))
