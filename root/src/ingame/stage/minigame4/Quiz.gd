extends Control

export (Dictionary) var allQuest
var QuestAtt = 0
var enemy = load("res://src/ingame/stage/minigame4/bicho.tscn")

func _ready():
	$Pergunt.text = allQuest.keys()[QuestAtt]
	$VBoxContainer.get_child(0).text = allQuest[allQuest.keys()[QuestAtt]][0]
	$VBoxContainer.get_child(1).text = allQuest[allQuest.keys()[QuestAtt]][1]
	$VBoxContainer.get_child(2).text = allQuest[allQuest.keys()[QuestAtt]][2]
	$VBoxContainer.get_child(3).text = allQuest[allQuest.keys()[QuestAtt]][3]

func spawn_bichinh(val):
	#val = 2
	#0 - 2 = exec
	for i in val:
		var bich_instnc = enemy.instance()
		$Bich.add_child(bich_instnc)
		
