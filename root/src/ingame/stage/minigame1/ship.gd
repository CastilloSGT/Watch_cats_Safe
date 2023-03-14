extends KinematicBody2D

# VARIAVEIS

#puxa o tiro
const PRE_TIRO= preload("res://src/ingame/stage/minigame1/tiro.tscn")

# var especificos da nave
var qntd_tiro: int = 5
var dano: int = 5

# var de movimento
var velocidade: Vector2
export(int) var speed = 150

# FUNÇÕES

# função que chama funções
func _physics_process(_delta: float) -> void: #roda durante todo nosso jogo
	moverNave()
	
	if (Input.is_action_just_pressed("ui_select")):	
		tirosDisponiveis()
		
# faz a nave se mexer
func moverNave() -> void:
	var direcao: Vector2 = Vector2 (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	
	velocidade = direcao * speed
	velocidade = move_and_slide(velocidade)

func atirarProjetil() -> void:
	var tiro = PRE_TIRO.instance() #inicia o tiro
	#pega a area que a nave esta e add um novo obj (tiro)
	get_parent().add_child(tiro)
	tiro.global_position = global_position + Vector2(0,-15)
	
func tirosDisponiveis() -> void:
	var tiros_disparados = get_tree().get_nodes_in_group("tiros").size()
	
	if(tiros_disparados < qntd_tiro):
		atirarProjetil()
