extends KinematicBody2D
# VARIAVEIS
var velocidade: Vector2
export(int) var speed = 60 #var para mover personagem

onready var animado = $animation

func _physics_process(_delta: float) -> void: #roda durante todo nosso jogo
	mexe()
	socos()
	
# move personagem
func mexe() -> void:
	var direcao: Vector2 = Vector2 (Input.get_action_strength("ui_right") 
	- Input.get_action_strength("ui_left"), 0)
	
	if direcao != Vector2.ZERO:
		animado.play(("walk"))
	else:
		animado.play("idle")
		
	velocidade = direcao * speed
	velocidade = move_and_slide(velocidade)
	
func socos():
	if Input.is_action_just_pressed("soco"):
		animado.play("soco")
	if Input.is_action_just_pressed("soco-forte"):
		animado.play("soco-forte")
	if Input.is_action_just_pressed("desvia"):
		animado.play("desvio")
