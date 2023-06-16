extends Node2D

# cria um auto load para salvar a ultima sala e assim resultar na posicao certa sla
var lugar

# DIALOGO
var obj
var areaOn
var dialogo_on = false

# SISTEMA DE FASES
var fase = 3
var pontos = [0,0,0,0,0]
var fase_concluida = false

#MINIGAME 1
var pacotes = 0
var dano = 5
var Boss_life

#MINIGAME 2
var tipo_dano = -1 # 0 = desvia, 1 = soco fraco, 2 = soco forte
var BANANA_ATTACK = false

var pos_fighter
var pos_enemy

var vida_fighter = 0
var vida_enemy = 0


# MINIGAME 3
var combo = 0
var maxCombo
var Score = 0

var sensorDown
var sensorTop
var sensorLeft
var sensorRight

var turno = false
var yes = false

#Music Cens
var Telas = false
var AUX = 0
var visibl = false
var Maps = 0


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
