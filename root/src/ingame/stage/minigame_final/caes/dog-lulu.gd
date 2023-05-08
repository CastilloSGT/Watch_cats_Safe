extends Node2D

var target: Vector2
var direcao: Vector2

var speed = 100
var posX = 0
var posY = 0

onready var animation_tree: AnimationTree = get_node("AnimationTree")
onready var estado_animado = animation_tree.get("parameters/playback")

func _ready():
	changePos()
	$Label.hide()

func _physics_process(delta):
	self.global_position = self.global_position.move_toward(target, speed * delta)
	animacao()
	getPos()

# ANIMAÇÕES
func animacao():
	if direcao != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", direcao)
		animation_tree.set("parameters/walk/blend_position", direcao)
		estado_animado.travel("walk")
	else:
		estado_animado.travel("idle")

# SE MOVE POR AI ALEATORIAMENTE
func getPos():
	var pos = self.global_position - target
	if(pos.x == 0):
		posX = 0
	else:
		posX = pos.x/abs(pos.x)
		
	if(pos.y == 0):
		posY = 0
	else:
		posY = pos.y/abs(pos.y)
		
	direcao = Vector2(posX,posY)

func changePos():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var posX = rng.randi_range(0, 512)
	var posY = rng.randi_range(0, 512)
	
	target = Vector2(posX,posY)

func _on_Timer_timeout():
	changePos()


func _on_dog_button_mouse_exited():
	$Label.hide()
func _on_dog_button_pressed():
	$Label.show()
