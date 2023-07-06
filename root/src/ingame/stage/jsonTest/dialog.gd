extends CanvasLayer

export(String, FILE, "*.json") var dialog_file

var dialogues = []
#export (Dictionary) var Dialogues
#@export var test_dic: Dictionary = ""
func _ready():
	play()
	#print(dialogues.size())	
	#print(dialogues)
	var j = 0
	#print(dialogues[0].size())
	var arrayAux = []
	for i in range(dialogues[0].size()):
		print(i)
		print(dialogues[0][str('watch_',i+1)])
		arrayAux.append(dialogues[0][str('watch_',i+1)])
	#print(arrayAux)

	#$NinePatchRect/RichTextLabel.text = dialogues[0]['Pergunta']
	#$NinePatchRect/RichTextLabel2.text = dialogues[0]['ops1']
	
	#$NinePatchRect/RichTextLabel.text = dialogues[2]["teste"][0]
	#$NinePatchRect/RichTextLabel2.text = dialogues[3]["teste"][1]
	
	#allQuest[allQuest.keys()[QuestAtt]][0]
	#print(Dialogues[Dialogues.keys()[0]][0])
	#print(dialogues.keys()[0])
	#var s = Dialogues.keys()[1]
	#print(s)
	#pergunta.text = allQuest.keys()[QuestAtt] 
	#resposta.get_child(0).text = allQuest[allQuest.keys()[QuestAtt]][0]
	"""
	print(dialogues[0]['ops'])
	print(dialogues[1]['op'])
	print(dialogues[0]['op'])
	print(dialogues[2]["teste"][0])
	print(dialogues[0])
	print(dialogues[1])
	print(dialogues)
	for n in dialogues:
		print(n)
		
	for n in range(8):
		print(n)
	
	var array1 = []
	var gtx = 1
	var gtxStr = String(gtx)
	array1 = dialogues[2][str('cats_',gtxStr)]
	var array2 = []
	var array3 = []
	var aux = []
	#print(array1[array1.size() - 1])
	""
	for n in array1:
		#print(n)
		if n == str(array1.size() - 1) || n == str(array1.size()):
			array2 = n
		else:
			aux = n
	
	for (int i = 0; i < 50; i++) {
		printf("Value: %s\n", i, strings[i]);
	}
	""
	var x = 0
	for i in range(array1.size()):
		if i == array1.size() - 1:
			#print(array1[i])
			array2.append(array1[i])
		elif i == array1.size() - 2:
			array3.append(array1[i])
		else:
			aux.append(array1[i])
			#x+=1
			#print(array2)
			#array2[x] = array1[i]
		#else:
			#print(array1[i] + "as")

		#else:
			#array2 = array1[i]
	#print(aux)
	print(array2)
	print(array3)
	print(aux)
	print(array1)
	#print(dialogues.size())
	"""
	
func tentativas():
	pass
	
	
	#for in range():
		#pass

func play():
	dialogues = carg()
	

func carg():
	var file = File.new()
	if file.file_exists(dialog_file):
		file.open(dialog_file,file.READ)
		return parse_json(file.get_as_text())
