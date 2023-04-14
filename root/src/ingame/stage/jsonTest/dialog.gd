extends CanvasLayer

export(String, FILE, "*.json") var dialog_file

var dialogues = []

func _ready():
	var i = 3
	play()
	$NinePatchRect/RichTextLabel.text = dialogues[i]["pergunt"]
	$NinePatchRect/RichTextLabel2.text = dialogues[i]["opstions"]

func play():
	dialogues = carg()

func carg():
	var file = File.new()
	if file.file_exists(dialog_file):
		file.open(dialog_file,file.READ)
		return parse_json(file.get_as_text())
