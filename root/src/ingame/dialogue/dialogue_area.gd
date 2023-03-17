extends Area2D

onready var entrouArea = false
onready var caixa = $caixa/Background
onready var nome = $caixa/Background/Name
onready var msg = $caixa/Background/Message

func _physics_process(_delta: float) -> void:
	caixa.hide()
	if entrouArea == true:
		caixaAberta()
	else:
		caixaFechada()

# FUNÇÃO BASICAS DA CAIXA
func caixaAberta():
	caixa.show()
	texto()
	apertou()
			
func caixaFechada():
	caixa.hide()
	entrouArea = false
	Global.btnSim = false

# FUNÇÃO BASICAS DO BOTÃO
func apertou():
	if Input.is_action_pressed("ui_select"):
		Global.btnSim = true

# VERIFICAÇÃO DE AREA
func _on_dialogue_area_area_entered(area):
	entrouArea = true
func _on_dialogue_area_area_exited(area):
	entrouArea = false
	
# TEXTO		
func texto():
	nome.set_text(str("Cama"))
	msg.set_text(str("Ir Dormir?"))
	
