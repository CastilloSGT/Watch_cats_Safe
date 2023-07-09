extends Node2D

export(String, FILE, "*.json") var dados_file

var crach = []

func _ready():
	play()
	
	$LogoEmpresa.text = "GatoCorp"
	$Nome.text = crach[0]['Tera']
	$intNumb.text = crach[0]['Arandu']
	$"Descrição".text = crach[0]['gustoPersonal']
	$Offic.text = crach[0]['mbaapoha']
	#$Nome.text = "Castillo"
	
	print(crach)

func play():
	crach = carg()

func carg():
	var file = File.new()
	if file.file_exists(dados_file):
		file.open(dados_file,file.READ)
		return parse_json(file.get_as_text())
