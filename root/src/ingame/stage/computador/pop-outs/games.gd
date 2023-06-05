extends Node2D

func _process(delta):
	if(Global.fase_concluida):
		$iniciar_game.hide()
		$resultado.show()
		if(Global.fase < 6):
			$resultado/textinho.set_bbcode(str("[wave] Você ganhou ", Global.pontos[Global.fase], " pontos"))
	else:
		$iniciar_game/Games.frame = Global.pontos[Global.fase]
		$resultado.hide()
		$iniciar_game.show()

func _on_iniciar_pressed():
	$iniciar_game.hide()
	var game
	match Global.fase:
		0:
			game = "minigame1/rat-attack.tscn"
		1:
			game = "minigame2/monkey-out.tscn"
	
	get_tree().change_scene(str("res://src/ingame/stage/",game))
	queue_free()

func _on_fechar_pressed():
	queue_free()
