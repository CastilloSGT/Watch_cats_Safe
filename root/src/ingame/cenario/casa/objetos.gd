extends Area2D
# COLISAO?
onready var player = $"../../player"

onready var cama_animation = $"../cama/Animation"
onready var comp_animation = $"../computador/Animation"
onready var janela_animation = $"../janelas/Animation"
		
func hackeando():
	get_tree().change_scene("res://src/ingame/stage/minigame1/rat-attack.tscn")

func _physics_process(_delta: float) -> void:
	nao_programando() #forçando vazio por bug
	caixaAberta()
	
func caixaAberta():
	if(Global.btnSim == true):
		match Global.obj:
			"cama":
				dormiu()
			"computador":
				programando()
	else:
		match Global.obj:
			"cama":
				acordou()
			"computador":
				nao_programando()

#ANIMAÇÕES
func dormiu():
	janela_animation.play("noite")
	cama_animation.play("dormindo")
	player.visible = false

func acordou():
	janela_animation.play("dia")
	cama_animation.play("vazia")
	player.visible = true

func programando():
	comp_animation.play("programando")
	player.visible = false
	
func nao_programando():
	comp_animation.play("vazio")
	player.visible = true
