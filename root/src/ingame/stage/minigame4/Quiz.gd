extends Control

export (Dictionary) var allQuest
var QuestAtt = 0
var totQuests = 0
var infos = 0

var desliga = false

#pontuação
var max_value = 120
var point = 10.3
var points = point*6

#iniciando var
onready var pergunta = $pergunta/Pergunt
onready var resposta = $resposta/VBoxContainer
onready var tempo = $tempo/Timer
onready var lbltempo = $tempo/Tempo
onready var inimigo = $inimigo/animation

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	totQuests = allQuest.size() #Tamanho total do Dictionary
	quest(QuestAtt)
	$tutorial/animation.play("trim")

func _physics_process(delta):
	lbltempo.text = "Timer\n" + str(int(tempo.time_left))
	changeProgressBar()
	
	if(points <= 0):
		gameOver()
	
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
			#se pegou uma info boa
			infos += 1
			points += point
			for i in resposta.get_child_count(): #Disabled checkbox durante a select
				resposta.get_child(i).disabled = true
			prox_quest()
		else:
			points -= point
			prox_quest()

func changeProgressBar():
	changeBunnyExpression()
	if($"barra-de-progresso/vida".rect_size.x <= 101):
		$"barra-de-progresso/vida".rect_size.x = points/1.3
	
func changeBunnyExpression():
	if (points > max_value/1.5):
		inimigo.play("ok")
		$"inimigo/Fundo-tela".modulate = Color("#37946e")
		
	elif (points < max_value/3):
		inimigo.play("angry")
		$"inimigo/Fundo-tela".modulate = Color("#ac3232")
		
	else:
		inimigo.play("sus")
		$"inimigo/Fundo-tela".modulate = Color("#5b6ee1")

func gameOver():
	tempo.stop()
	if(!desliga):
		desliga()
	
	if(infos > 2):
		Global.fase_concluida = true
		Global.pontos[3] = points * infos 
		Global.lost_count = 0

func desliga():
	$tutorial.show()
	$tutorial/animation.play("out")
	yield($tutorial/animation,"animation_finished")
	$gameover.show()
	$tempo/gameover.start()
	Global.lost_count += 1
	desliga = true

func _on_tutorial_timeout():
	$tutorial.hide()
	tempo.start()

func _on_gameover_timeout():
	get_tree().paused = false
	get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")

func _on_Timer_timeout():
	prox_quest()
	points -= point
