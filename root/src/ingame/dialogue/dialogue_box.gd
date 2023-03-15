extends CanvasLayer

# VARIAVEIS
export (String, FILE, "*json") var dialogue_file
#onready var btnPositive = $Background/caixinha/positive
var dialogues = []

# funções basicas
func _ready():
	$Background.hide()

func play():
	dialogues = load_dialogue()
	$Background.show()
	$Background/Name.text = dialogues[0]['name']
	$Background/Message.text = dialogues[0]['text']

# transforma json em variavel
func load_dialogue():
	var file = File.new()
	if file.file_exists(dialogue_file):
		file.open(dialogue_file, File.READ)
		return parse_json(file.get_as_text())
