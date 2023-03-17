extends Area2D
# COLISAO?
var onareaComp = false

onready var computador = $Computador
onready var programando = $Programando
onready var player = $"../../player"
onready var cama_animation = $Animation
onready var janela_animation = $"../janelas/Animation"
		
func hackeando():
	get_tree().change_scene("res://src/ingame/stage/minigame1/rat-attack.tscn")

func _physics_process(_delta: float) -> void:
	caixaAberta()
	if(Input.is_action_just_pressed("ui_select")):
		if (onareaComp == true):
			hackeando()
	
func _on_computador_body_exited(body):
	onareaComp = false
	programando.hide()
	computador.show()
	player.visible = true
	
func _on_computador_body_entered(body):
	onareaComp = true
	programando.show()
	computador.hide()
	player.visible = false
	
func caixaAberta():
	if(Global.btnSim == true):
		dormiu()
	else:
		acordou()

func dormiu():
	#cama_animation.play("dormindo")
	#janela_animation.play("noite")
	player.visible = false

func acordou():
	#cama_animation.play("vazia")
	#janela_animation.play("dia")
	player.visible = true
