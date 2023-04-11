extends Control

export (Dictionary) var allQuest
var QuestAtt = 0
var totQuests = 0

var posX = 0
var posAnt = 0
var posPos = 0

#iniciando var
onready var pergunta = $pergunta/Pergunt
onready var resposta = $resposta/VBoxContainer
onready var tempo = $tempo/Timer
onready var lbltempo = $tempo/Tempo
onready var tilemap = $"barra-progresso/TileMap"
onready var inimigo = $inimigo/animation

func _ready():
	totQuests = allQuest.size() #Tamanho total do Dictionary
	quest(QuestAtt)
	posX = 5
	tilemap.set_cell(4,0,5)
	tilemap.set_cell(3,0,5)
	tilemap.set_cell(2,0,5)
	tilemap.set_cell(1,0,2)

func _physics_process(delta):
	lbltempo.text = "Timer\n" + str(int(tempo.time_left))
	changeProgressBar()
	changeBunnyExpression()

func quest(QuestAtt):
	pergunta.text = allQuest.keys()[QuestAtt] 
	resposta.get_child(0).text = allQuest[allQuest.keys()[QuestAtt]][0]
	resposta.get_child(1).text = allQuest[allQuest.keys()[QuestAtt]][1]
	resposta.get_child(2).text = allQuest[allQuest.keys()[QuestAtt]][2]
	resposta.get_child(3).text = allQuest[allQuest.keys()[QuestAtt]][3]
	
func prox_quest():
	QuestAtt += 1 #Contagem da questão atual
	
	for i in resposta.get_children(): #Disabled checkbox durante a select
		i.disabled = false
		i.pressed = false
	
	if totQuests > 1: #Se ainda exist Questões no Dictionary atualiza o conteudo da VBoxContainer
		quest(QuestAtt)
		totQuests -= 1
	else:
		get_tree().change_scene_to(load("res://src/interface/fim_prototipo.tscn"))

func _on_item_toggled(button_pressed, questMark):
	if button_pressed: #se button == true
		if questMark == allQuest[allQuest.keys()[QuestAtt]][4]:
			posX += 1
			for i in resposta.get_child_count(): #Disabled checkbox durante a select
				resposta.get_child(i).disabled = true
			prox_quest()
		else:
			posX -= 1
			prox_quest()

func changeProgressBar():
	posAnt = posX - 1
	posPos = posX + 1
	
	if(posX != 0): #a mãozinha não conta
		
		#não sendo o primeiro nem o ultimo
		if posX != 1 && posX != 10:
			tilemap.set_cell(posX,0,4)
			#nem limpando eles de outra forma
			if(posAnt != 1 && posPos != 10):
				tilemap.set_cell(posAnt,0,5)
				tilemap.set_cell(posPos,0,3)
				
			# se for
			if(posAnt == 1):
				tilemap.set_cell(posAnt,0,2)
				tilemap.set_cell(posPos,0,3)
			if(posPos == 10):
				tilemap.set_cell(posAnt,0,5)
				tilemap.set_cell(posPos,0,7)
	else:
		tilemap.set_cell(posPos,0,1) #faz o primeiro vazio
	
func changeBunnyExpression():
	if (posX > 7):
		inimigo.play("ok")
	if (posX > 5 && posX < 7):
		inimigo.play("sus")
	if (posX < 4):
		inimigo.play("angry")
