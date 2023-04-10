extends Node2D

const left = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_left.tscn")
const up = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_up.tscn")
const right = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_right.tscn")
const down = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_down.tscn")

onready var control_spaw = $Control_spaw

#TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor
var novoRound = false

#NOTAS
var sequence = [
	[1,2,3,4,-1,-1], [1,2,3,4,-1,-1],
	[1,1,1,4,2,1,-1,-1,-1], [1,1,1,4,2,1,-1,-1,-1],
	[1,2,2,3,2,1,1,-1,-1,-1,-1,-1,-1], [1,2,2,3,2,1,1,-1,-1,-1,-1,-1,-1],
	[1,2,3,4,-1,-1,-1,-1], [1,2,3,4,-1,-1,-1,-1]
]
#os -1 não são lidos e dão um tempo
#ja que nao conseguimos controlar o tempo por algum motivo
var i = 0
var j = 0

func _process(delta):
	maxCombo()
	setLabels()
	pauseTime()
	
func setLabels():
	$Labels/lblScore.text = str("Score: ",Global.Score)
	$Labels/lblCombo.text = str("x",Global.combo)
	
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

func combo(maxSubItem, j):
	var terco = maxSubItem/3
	var doistercos = terco * 2
	
	if(j == doistercos):
		Global.yes = true
	else:
		Global.yes = false
		
func _on_Timer_timeout():
	control_spaw.start()
	control_spaw.set_wait_time(1)
	var maxItem = sequence.size()
	var maxSubItem = sequence[i].size()
	combo(maxSubItem, j)
	
	if(j == maxSubItem):
		Global.yes = true
		i += 1
		j = 0
		Global.turno = !Global.turno
		
	if(i == maxItem):
		i = -1
		reset()
		
	if (i == 4):
		control_spaw.set_wait_time(0.5)
		if(!novoRound):
			chanceCenario()
		
	if(i != -1):
		if(Global.turno):
			playerArrows(sequence[i][j])
		else:
			enemyArrows(sequence[i][j])
		j += 1
		
func reset():
	get_tree().change_scene("res://src/interface/fim_prototipo.tscn")
	Global.Score = 0
	Global.combo = 0
	
func chanceCenario():
	wait_time = 20
	novoRound = true
	$cenario/round1.hide()
	$cenario/round2.show()
	
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
	
func pauseTime():
	if(is_timer_running):
		get_tree().paused = true
		$"pause-mode".show()
	else:
		get_tree().paused = false
		$"pause-mode".hide()
	
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false
