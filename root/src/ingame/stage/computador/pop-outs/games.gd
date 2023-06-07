extends Node2D

func _process(delta):
	if(Global.fase_concluida):
		$iniciar_game.hide()
		$resultado.show()
		$resultado/fechar.grab_focus()
		if(Global.fase < 6):
			$resultado/textinho.set_bbcode(str("[wave] Você ganhou ", Global.pontos[Global.fase], " pontos"))
	else:
		$iniciar_game/Games.frame = Global.fase
		$resultado.hide()
		$iniciar_game.show()
		$iniciar_game/iniciar.grab_focus()

func _on_iniciar_pressed():
	$iniciar_game.hide()
	var game
	match Global.fase:
		0:
			game = "minigame1/rat-attack.tscn"
		1:
			game = "minigame2/monkey-out.tscn"
		2:
			game = "minigame3/MuuGame.tscn"
	
	get_tree().change_scene(str("res://src/ingame/stage/",game))
	queue_free()

func _on_fechar_pressed():
	queue_free()
