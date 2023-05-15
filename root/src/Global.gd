extends Node2D

# cria um auto load para salvar a ultima sala e assim resultar na posicao certa sla
var lugar

# DIALOGO
var obj
var areaOn

#MINIGAME 1
var pacotes = 0
var dano = 5
var Boss_life

#MINIGAME 2
var tipo_dano = -1 # 0 = desvia, 1 = soco fraco, 2 = soco forte
var area_enemy = false #sensor
var pontos_dano = 0 #exibe na tela a quantidade de dano causado


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


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
