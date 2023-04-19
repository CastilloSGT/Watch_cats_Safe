extends Area2D
# VARIAVEIS

# var de movimento
var velocidade: Vector2
export(int) var speed = 150

#FUNCOES
func _physics_process(_delta: float) -> void:
	position.y -= speed * _delta

#quando some da tela
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_tiro_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
