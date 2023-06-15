extends Control

export (Dictionary) var allQuest
var QuestAtt = 0
var totQuests = 0
var points = 5

#iniciando var
onready var pergunta = $pergunta/Pergunt
onready var resposta = $resposta/VBoxContainer
onready var tempo = $tempo/Timer
onready var lbltempo = $tempo/Tempo
onready var inimigo = $inimigo/animation

func _ready():
	tempo.wait_time = 10
	tempo.start()
	
	totQuests = allQuest.size() #Tamanho total do Dictionary
	quest(QuestAtt)

func _physics_process(delta):
	lbltempo.text = "Timer\n" + str(int(tempo.time_left))
	changeProgressBar()
	changeBunnyExpression()
	gameOver()
	print(totQuests)

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
		gameOver()

func _on_item_toggled(button_pressed, questMark):
	if button_pressed: #se button == true
		if questMark == allQuest[allQuest.keys()[QuestAtt]][4]:
			points += 10
			for i in resposta.get_child_count(): #Disabled checkbox durante a select
				resposta.get_child(i).disabled = true
				
			tempo.wait_time += 10.0
			tempo.start() #godot burrinha tem que dar start no timer toda hora
			prox_quest()
		else:
			points -= 10
			prox_quest()

func changeProgressBar():
	if($"barra-de-progresso/vida".rect_size.x <= 101):
		$"barra-de-progresso/vida".rect_size.x += points/10.2
	
func changeBunnyExpression():
	if (points > 7):
		inimigo.play("ok")
		$"inimigo/Fundo-tela".modulate = Color("#37946e")
		
	if (points> 3 && points < 7):
		inimigo.play("sus")
		$"inimigo/Fundo-tela".modulate = Color("#5b6ee1")
		
	if (points < 3):
		inimigo.play("angry")
		$"inimigo/Fundo-tela".modulate = Color("#ac3232")

func gameOver():
	if(tempo.time_left == 0.0):
		tempo.stop()
		$gameover.show()
		tempo.wait_time = 3.0
		tempo.start()
		
	if((tempo.wait_time == 3.0 && tempo.time_left < 1) || totQuests <= 1):
		get_tree().paused = false
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")
