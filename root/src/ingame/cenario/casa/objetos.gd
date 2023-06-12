extends Area2D
# COLISAO?
onready var player = $"../../player"

onready var cama_animation = $"../cama/Animation"
onready var comp_animation = $"../computador/Animation"
onready var janela_animation = $"../janelas/Animation"

onready var timer = $"../../Timer"
onready var timer_sono = $"../modo_noite/timer_sono"
onready var tilemap = $"../../TileMap"

var dormindo = false

func _ready():
	$"../computador/logando".hide()

func _physics_process(_delta: float) -> void:
	caixaAberta()
	dia_completo()
	
func caixaAberta():
	if(Global.areaOn == true):
		match Global.obj:
			"cama":
				dormiu()
			"computador":
				programando()
	else:
		match Global.obj:
			"computador":
				nao_programando()

func dia_completo():
	if(Global.fase_concluida):
		janela_animation.play("noite")
		$"../modo_noite/modulate".show()
		
		#tranca player no quarto
		tilemap.set_cell(4,8,32)
		tilemap.set_cell(5,8,32)
		tilemap.set_cell(6,8,32)
		tilemap.set_cell(7,8,32)
		
	else:
		janela_animation.play("dia")
		$"../modo_noite/modulate".hide()
		
		#destranca player do quarto
		tilemap.set_cell(4,8,17)
		tilemap.set_cell(5,8,30)
		tilemap.set_cell(6,8,30)
		tilemap.set_cell(7,8,19)

#ANIMAÇÕES
func dormiu():
	if(Global.fase_concluida):
		if(!dormindo):
			timer_sono.start()
			dormindo = true
			
		cama_animation.play("dormindo")
		get_node("../../player").set_physics_process(false)
		player.visible = false
	else:
		#animação do gato negando
		pass

func acordou():
	if(dormindo):
		cama_animation.play("vazia")
		get_node("../../player").set_position($"../modo_noite/camapos".position)
		get_node("../../player").set_physics_process(true)
		
		Global.fase_concluida = false
		player.visible = true
		dormindo = false
		Global.fase += 1

func programando():
	if(!Global.fase_concluida):
		comp_animation.play("programando")
		player.visible = false
		$"../computador/logando".show()
		
		yield(comp_animation,"animation_finished")
		get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")
	else:
		pass #gato negando mesma animação
		
func nao_programando():
	comp_animation.play("vazio")
	$"../computador/logando".hide()
	player.visible = true
	
#TIMER
func _on_timer_sono_timeout():
	acordou()
