extends Node2D

const left = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_left.tscn")
const up = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_up.tscn")
const right = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_right.tscn")
const down = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_down.tscn")

var RNG = RandomNumberGenerator.new()

func _process(delta):
	maxCombo()
	setLabels()
	
func setLabels():
	$Labels/lblScore.text = str("Score: ",Global.Score)
	$Labels/lblCombo.text = str("x",Global.combo)
	$"Labels/label-colorida".text = str("MAX COMBO")
		
func maxCombo():
	if(Global.combo == 5):
		Global.maxCombo = true
	else:
		Global.maxCombo = false
	
	if (Global.maxCombo):
		$Labels/lblCombo.hide()
		$"Labels/label-colorida".show()
	else:
		$"Labels/label-colorida".hide()
		if(Global.combo >= 2):
			$Labels/lblCombo.show()
		else:
			$Labels/lblCombo.hide()
	
func _on_Timer_timeout():
	$Control_spaw.start()
	RNG.randomize()
	var random_int = RNG.randi_range(0,4)
	if(Global.turno):
		playerArrows(random_int)
	else:
		enemyArrows(random_int)
		
func playerArrows(select_sets):
	if select_sets == 1:
		var Left = left.instance()
		get_parent().add_child(Left)
		Left.position = $player_arrows/SpawArrow/Position_left.global_position

	if select_sets == 2:
		var Up = up.instance()
		get_parent().add_child(Up)
		Up.position = $player_arrows/SpawArrow/Position_up.global_position

	if select_sets == 3:
		var Right = right.instance()
		get_parent().add_child(Right)
		Right.position = $player_arrows/SpawArrow/Position_right.global_position
		
	if select_sets == 4:
		var Down = down.instance()
		get_parent().add_child(Down)
		Down.position = $player_arrows/SpawArrow/Position_down.global_position

func enemyArrows(select_sets):
	if select_sets == 1:
		var Left = left.instance()
		get_parent().add_child(Left)
		Left.position = $enemy_arrows/SpawArrow/Position_left.global_position

	if select_sets == 2:
		var Up = up.instance()
		get_parent().add_child(Up)
		Up.position = $enemy_arrows/SpawArrow/Position_up.global_position
		
	if select_sets == 3:
		var Right = right.instance()
		get_parent().add_child(Right)
		Right.position = $enemy_arrows/SpawArrow/Position_right.global_position
		
	if select_sets == 4:
		var Down = down.instance()
		get_parent().add_child(Down)
		Down.position = $enemy_arrows/SpawArrow/Position_down.global_position

