extends CanvasLayer

export(String, FILE, "*.json") var dialog_file

var dialogues = []
#export (Dictionary) var Dialogues
#@export var test_dic: Dictionary = ""
func _ready():
	play()
	#$NinePatchRect/RichTextLabel.text = dialogues[0]['Pergunta']
	#$NinePatchRect/RichTextLabel2.text = dialogues[0]['ops1']
	
	$NinePatchRect/RichTextLabel.text = dialogues[2]["teste"][0]
	$NinePatchRect/RichTextLabel2.text = dialogues[3]["teste"][1]
	
	#allQuest[allQuest.keys()[QuestAtt]][0]
	#print(Dialogues[Dialogues.keys()[0]][0])
	#print(dialogues.keys()[0])
	#var s = Dialogues.keys()[1]
	#print(s)
	#pergunta.text = allQuest.keys()[QuestAtt] 
	#resposta.get_child(0).text = allQuest[allQuest.keys()[QuestAtt]][0]
	
	print(dialogues[0]['ops'])
	print(dialogues[1]['op'])
	print(dialogues[0]['op'])
	print(dialogues[2]["teste"][0])
	print(dialogues)

func play():
	dialogues = carg()

func carg():
	var file = File.new()
	if file.file_exists(dialog_file):
		file.open(dialog_file,file.READ)
		return parse_json(file.get_as_text())
