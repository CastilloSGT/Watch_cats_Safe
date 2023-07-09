extends Node2D

# SETAS
const left = preload("res://src/ingame/stage/minigame3/arrows_move/arrows/movearrow_left.tscn")
const up = preload("res://src/ingame/stage/minigame3/arrows_move/arrows/movearrow_up.tscn")
const right = preload("res://src/ingame/stage/minigame3/arrows_move/arrows/movearrow_right.tscn")
const down = preload("res://src/ingame/stage/minigame3/arrows_move/arrows/movearrow_down.tscn")

# SETAS LONGAS
var longUp = preload("res://src/ingame/stage/minigame3/arrows_move/longArrows/longarrow_up.tscn").duplicate()
var longDown = preload("res://src/ingame/stage/minigame3/arrows_move/longArrows/longarrow_down.tscn").duplicate()
var longLeft = preload("res://src/ingame/stage/minigame3/arrows_move/longArrows/longarrow_left.tscn").duplicate()
var longRight = preload("res://src/ingame/stage/minigame3/arrows_move/longArrows/longarrow_right.tscn").duplicate()

const buraco = preload("res://src/ingame/stage/minigame3/arrows_move/buraco.tscn")

onready var control_spaw = $timers/Control_spaw
onready var delay_timer = $timers/delay;
onready var my_timer = $timers/Timer;
onready var tutorial_timer = $timers/tutorial/tutorial_timer;
onready var reset = $timers/reset;

var timeDefined = 0
var _round = 0

#Json Export
export(String, FILE, "*.json") var dialog_file
#Array OBJ
var dialogues = []
var array1 = []

#NOTAS
var sequence = [
	#fazer json buscar o -3 e buscar um -1 pra fase
	[1,2,3,4,-2,-1], [1,2,3,4,-2,-1],
	#[1,1,1,4,2,1,-3,-1], [1,1,1,4,2,1,-3,-1],
	#[1,2,6,3,2,5,5,-4,-2], [1,2,6,3,2,5,5,-4,-2],
	#[5,6,6,6,-2,-1], [5,6,7,8,-6,-1]
]

var sequence2 = [
	#fazer json buscar o -3 e buscar um -1 pra fase
	#[1,2,3,4,-2,-1], [1,2,3,4,-2,-1],
	#[1,1,1,4,2,1,-3,-1], [1,1,1,4,2,1,-3,-1],
	#[1,2,6,3,2,5,5,-4,-2], [1,2,6,3,2,5,5,-4,-2],
	[5,6,6,6,-2,-1], [5,6,7,8,-6,-1]
]
var i = 0
var j = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	ler()
	print(array1)
	print(sequence)

func _process(delta):
	changeBarPos()
	maxCombo()
	$Labels/lblCombo.text = str("x",Global.combo)
	
#Json Read
func ler():
	var file = File.new()
	if file.file_exists(dialog_file):
		file.open(dialog_file,file.READ)
		dialogues = parse_json(file.get_as_text())
		#return parse_json(file.get_as_text())
	
	for i in range(dialogues[0].size()):
		array1.append(dialogues[0][str('watch_',i+1)])
	#print(dialogues)

# COMBOS	
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

# SETAS
func spawnArrows():
	verifyArrows()
	if(delay_timer.time_left == 0):
		#print(array1[i][j])
		#print(sequence[i][j])
		arrowsPos(int(array1[i][j]))
		#arrowsPos(array1[i][j])
		j += 1

func verifyArrows():
	control_spaw.start()
	control_spaw.set_wait_time(1)
	var maxItem = array1.size()
	
	#var aux = sequence[i].size() -2
	#var aux1 = abs(sequence[i][aux])
	#print(aux1)
	
	
	#var aux2 = array1[i].size() -2
	#var aux11 = abs(int(array1[i][aux2]))
	#print(aux11)
	
	#var maxSubItem2 = sequence[i].size() -2 #nao pega o timer
	var maxSubItem = array1[i].size() - 2
	#print(maxSubItem)
	#print(maxSubItem2)
	
	
	combo(maxSubItem, j)
	#timeDefined = abs(sequence[i][maxSubItem])
	timeDefined = abs(int(array1[i][maxSubItem]))
	#_round = abs(sequence[i][maxSubItem+1]) #sem ABS já q n tem -
	_round = abs(int(array1[i][maxSubItem+1]))
	
	if(j == maxSubItem):
		Global.yes = true
		i += 1
		j = 0
		delay_timer.wait_time = timeDefined #converter
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
	
func arrowsPos(select_sets):
	var pos
	var seta
	var color
	
	var Buraco = buraco.instance()
	if(Global.turno):
		pos = "player_arrows/SpawArrow/"
	else:
		pos = "enemy_arrows/SpawArrow/"
	
	match select_sets:
		1 : 
			seta = left.instance()
			pos += "Position_left"
			color = Color("#924196")
		2:
			seta = up.instance()
			pos += "Position_up"
			color = Color("#37946e")
		3:
			seta = right.instance()
			pos += "Position_right"
			color = Color("#ac3232")
		4:
			seta = down.instance()
			pos += "Position_down"
			color = Color("#5b6ee1")
			
		# LONG ARROW
		5:
			seta = longLeft.instance()
			pos += "Position_left"
			color = Color("#924196")
		6:
			seta = longUp.instance()
			pos += "Position_up"
			color = Color("#37946e")
		7:
			seta = longRight.instance()
			pos += "Position_right"
			color = Color("#ac3232")
		8:
			seta = longDown.instance()
			pos += "Position_down"
			color = Color("#5b6ee1")
	
	get_parent().add_child(Buraco)
	Buraco.modulate = color
	Buraco.position = get_node(pos).global_position
	
	get_parent().add_child(seta)
	seta.position = get_node(pos).global_position

# BARRA
func changeBarPos():
	var color
	if(Global.Score <= -33):
		color = Color("#ac3232")
	elif(Global.Score >= 33):
		color = Color("#5b6ee1")
	else:
		color = Color("#924196")
	
	$"Labels/barra/barra-cor".self_modulate = color
	var icon = $Labels/barra/icons
	if(icon.position.x <= 224 && icon.position.x >= 128):
		icon.position.x = 168 + (Global.Score/4)

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
	if(Global.Score > 0):
		Global.pontos[2] = Global.Score * Global.combo
		Global.fase_concluida = true
		Global.lost_count = 0
	else:
		Global.lost_count += 1
		Global.fase_concluida = false
		
	get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")
	#reset
	Global.Score = 0
	Global.combo = 0
