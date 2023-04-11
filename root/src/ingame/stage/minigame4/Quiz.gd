extends Control

export (Dictionary) var allQuest
var QuestAtt = 0
var totQuests = 0
var pontos = 0
var enemy = load("res://src/ingame/stage/minigame4/bicho.tscn")

func _ready():
	totQuests = allQuest.size() #Tamanho total do Dictionary
	#Setando texto na label e checksBoxs(VBoxContainer)
	$Pergunt.text = allQuest.keys()[QuestAtt] 
	$VBoxContainer.get_child(0).text = allQuest[allQuest.keys()[QuestAtt]][0]
	$VBoxContainer.get_child(1).text = allQuest[allQuest.keys()[QuestAtt]][1]
	$VBoxContainer.get_child(2).text = allQuest[allQuest.keys()[QuestAtt]][2]
	$VBoxContainer.get_child(3).text = allQuest[allQuest.keys()[QuestAtt]][3]

func _physics_process(delta):
	$Tempo.text = "Timer\n" + str(int($Timer_1.time_left))
	$Ponts.text = "Pontos\n" + str(pontos)
	
#Seleção de perguntas/Cambio
func prox_quest():
	$Timer_1.paused = false
	$Timer_1.start()
	QuestAtt += 1 #Contagem da questão atual
	
	for i in $VBoxContainer.get_children(): #Disabled checkbox durante a select
		i.disabled = false
		i.pressed = false
	
	if totQuests > 1: #Se ainda exist Questões no Dictionary atualiza o conteudo da VBoxContainer
		$Pergunt.text = allQuest.keys()[QuestAtt] 
		$VBoxContainer.get_child(0).text = allQuest[allQuest.keys()[QuestAtt]][0]
		$VBoxContainer.get_child(1).text = allQuest[allQuest.keys()[QuestAtt]][1]
		$VBoxContainer.get_child(2).text = allQuest[allQuest.keys()[QuestAtt]][2]
		$VBoxContainer.get_child(3).text = allQuest[allQuest.keys()[QuestAtt]][3]
		totQuests -= 1
	else:
		get_tree().change_scene_to(load(""))

func _on_item_toggled(button_pressed, questMark):
	if button_pressed: #se button == true
		if $Timer_1.time_left > 0:
			if questMark == allQuest[allQuest.keys()[QuestAtt]][4]:
				pontos += 100
				for i in $VBoxContainer.get_child_count(): #Disabled checkbox durante a select
					$VBoxContainer.get_child(i).disabled = true
				prox_quest()
			else:
				prox_quest()

