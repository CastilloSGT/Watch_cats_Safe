extends Node2D
var target: Vector2;
var speed = 100
var direcao = Vector2.ZERO

onready var animation_tree: AnimationTree = get_node("sprite/AnimationTree")
onready var estado_animado = animation_tree.get("parameters/playback")

func _ready():
	changePos()

func _physics_process(delta):
	self.global_position = self.global_position.move_toward(target, speed * delta)
	
	var pos = self.global_position - target
	print(pos.x/abs(pos.x))

# ANIMAÇÕES
func animacao():
	if direcao != Vector2.ZERO:
		animation_tree.set("parameters/idle/blend_position", direcao)
		animation_tree.set("parameters/walk/blend_position", direcao)
		estado_animado.travel("walk")
	else:
		estado_animado.travel("idle")

# SE MOVE POR AI ALEATORIAMENTE
func changePos():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var posX = rng.randi_range(0, 512)
	var posY = rng.randi_range(0, 512)
	
	target = Vector2(posX,posY)

func _on_Timer_timeout():
	changePos()
