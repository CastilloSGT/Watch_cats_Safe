extends KinematicBody2D

# VARIAVEIS

var velocidade: Vector2
export(int) var speed = 60 #var para mover personagem
# var de animacao
onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var estado_animado = animation_tree.get("parameters/playback")

# FUNCOES

# funcao q chama funcoes
func _physics_process(_delta: float) -> void: #roda durante todo nosso jogo
	mexe()
	
# move personagem
func mexe() -> void:
	# move ele em 8 direcoes mui pica
	var direcao: Vector2 = Vector2 (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()
	
	velocidade = direcao * speed
	velocidade = move_and_slide(velocidade)
	
# p/ animar personagem
	if direcao != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", direcao)
		animation_tree.set("parameters/walk/blend_position", direcao)
		estado_animado.travel("walk")
	else:
		estado_animado.travel("idle")
		

