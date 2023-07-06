extends Node2D

export(String, FILE, "*.json") var cracha
var brach = []
var array1 = []
func _ready():
	preench(0)
	#array1[0][4]

func preench(x):
	leitura_Json()	
	$Control/INTELIGENCIA.text = array1[x][0]
	$Control/CARGO.text = array1[x][1]
	$Control/EMOCAO.text = array1[x][2]
	$Control/DESCRIPT.text = array1[x][3]
	$Control/IMG.texture = load(array1[x][4])

func leitura_Json():
	var file = File.new()
	if file.file_exists(cracha):
		file.open(cracha,file.READ)
		brach = parse_json(file.get_as_text())
	for i in range(brach[0].size()):
		array1.append(brach[0][str('watch_',i+1)])
