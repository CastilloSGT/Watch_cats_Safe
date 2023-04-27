extends Area2D
export(int) var speed = 100
onready var animation = $AnimationPlayer

var motion = false
var life = Global.dano

func _physics_process(delta: float) -> void:
	if(life < 1):
		animation.play("dead")
		yield(animation,"animation_finished")
		queue_free()
		
	else:
		animation.play("enemy_walk")
		if(motion):	
			position.x -= speed * delta
		else:
			position.x += speed * delta
		
func _on_VisibilityNotifier2D_screen_exited():
	$NaveEnemy.set_flip_h(motion)
	motion = !motion

func _on_enemyship_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(life == Global.dano):
		Global.pacotes += 1
	life -= Global.dano
