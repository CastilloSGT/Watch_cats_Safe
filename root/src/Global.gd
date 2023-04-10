extends Node2D

# cria um auto load para salvar a ultima sala e assim resultar na posicao certa sla
var lugar

# DIALOGO
var obj
var btnSim

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

