extends Area2D

onready var entrouArea = false
onready var fechou = false

onready var caixa = $caixa/Background
onready var nome = $caixa/Background/Name
onready var msg = $caixa/Background/Message

func _physics_process(_delta: float) -> void:
	caixa.hide()
	if entrouArea == true && fechou == false:
		caixaAberta()
	else:
		caixa.hide()
		
	if entrouArea == false:
		Global.btnSim = false
		fechou = false

# FUNÇÃO BASICAS DA CAIXA
func caixaAberta():
	caixa.show()
	texto()
	apertou()

# FUNÇÃO BASICAS DO BOTÃO
func apertou():
	if Input.is_action_pressed("btnSim"):
		caixa.hide()
		Global.btnSim = true
		fechou = true
	if Input.is_action_pressed("btnNao"):
		caixa.hide()
		fechou = true

# VERIFICAÇÃO DE AREA
func _on_dialogue_area_area_entered(area):
	#pega o nome do obj onde o gatinho entrou
	Global.obj = get_parent().name
	entrouArea = true
			
func _on_dialogue_area_area_exited(area):
	entrouArea = false
	
# TEXTO		
func texto():
	match Global.obj:
		"cama":
			nome.set_text(str("Cama"))
			msg.set_text(str("Ir Dormir?"))
		"computador":
			nome.set_text(str("Computador"))
			msg.set_text(str("Logar no computador?"))
