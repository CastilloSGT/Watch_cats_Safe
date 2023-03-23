extends KinematicBody2D
# VARIAVEIS
var velocidade: Vector2
export(int) var speed = 60 #var para mover personagem

onready var estado_animado = $AnimationTree
onready var vetor = Vector2(0,0)

func _physics_process(_delta: float) -> void: #roda durante todo nosso jogo
	mexe()
	animacao()
	
# move personagem
func mexe() -> void:
	var direcao: Vector2 = Vector2 (Input.get_action_strength("ui_right") 
	- Input.get_action_strength("ui_left"), 0)
	
	if direcao != Vector2.ZERO:
		vetor = Vector2(5,0)
	else:
		vetor = Vector2(4,0)
		
	velocidade = direcao * speed
	velocidade = move_and_slide(velocidade)
	
func animacao():
	estado_animado.set("parameters/estado/blend_position", vetor);
	print(vetor)
	if (Input.is_action_just_pressed("desvia")):
		vetor = Vector2(1,0)
	if (Input.is_action_just_pressed("soco")):
		vetor = Vector2(2,0)
	if (Input.is_action_just_pressed("soco-forte")):
		vetor = Vector2(3,0)
