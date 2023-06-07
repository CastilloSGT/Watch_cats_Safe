extends Node2D

const left = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_left.tscn")
const up = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_up.tscn")
const right = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_right.tscn")
const down = preload("res://src/ingame/stage/minigame3/arrows_move/movearrow_down.tscn")

onready var control_spaw = $timers/Control_spaw
onready var delay_timer = $timers/delay;
onready var my_timer = $timers/Timer;
onready var tutorial_timer = $timers/tutorial/tutorial_timer;
onready var reset = $timers/reset;

var timeDefined = 0
var _round = 0

#NOTAS
var sequence = [
	#fazer json buscar o -3 e buscar um -1 pra fase
	#[1,2,3,4,-2,-1], [1,2,3,4,-2,-1],
	#[1,1,1,4,2,1,-3,-1], [1,1,1,4,2,1,-3,-1],
	#[1,2,2,3,2,1,1,-4,-2], [1,2,2,3,2,1,1,-4,-1],
	[1,2,3,4,-2,-1], [1,2,3,4,-6,-1]
]
var i = 0
var j = 0

func _process(delta):
	maxCombo()
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

func spawnArrows():
	verifyArrows()
	if(delay_timer.time_left == 0):
		if(Global.turno):
			playerArrows(sequence[i][j])
		else:
			enemyArrows(sequence[i][j])
		j += 1

func verifyArrows():
	control_spaw.start()
	control_spaw.set_wait_time(1)
	var maxItem = sequence.size()
	
	var maxSubItem = sequence[i].size() -2 #nao pega o timer
	combo(maxSubItem, j)
	timeDefined = abs(sequence[i][maxSubItem])
	_round = abs(sequence[i][maxSubItem+1])
	
	if(j == maxSubItem):
		Global.yes = true
		i += 1
		j = 0
		delay_timer.wait_time = timeDefined
		delay_timer.start()
		
	if(i == maxItem):
		control_spaw.stop()
		reset.start()
	
func chanceCenario():
	#timer
	my_timer.start()
	get_tree().paused = true
	$"pause-mode".show()
	
	control_spaw.set_wait_time(0.5)
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

func _on_delay_timeout():
	Global.turno = !Global.turno
	if(_round == 2):
		chanceCenario()

func _on_tutorial_timer_timeout():
	$timers/tutorial.hide()
	self.set_process(true)
	$timers/Control_spaw.start()

func _on_Timer_timeout():
	get_tree().paused = false
	$"pause-mode".hide()

func _on_Control_spaw_timeout():
	spawnArrows()

func _on_reset_timeout():
	Global.pontos[2] = (Global.Score * Global.combo)
	Global.fase_concluida = true
	get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")
