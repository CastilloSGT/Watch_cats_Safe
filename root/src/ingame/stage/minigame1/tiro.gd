extends KinematicBody2D
# VARIAVEIS

# var de movimento
var velocidade: Vector2
export(int) var speed = 150

#FUNCOES

#chama funcoes
func _physics_process(_delta: float) -> void:
	el_camino()

func el_camino():
	var direcao: Vector2 = Vector2 (0,-1)
	
	velocidade = direcao * speed
	velocidade = move_and_slide(velocidade)

#quando some da tela
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
