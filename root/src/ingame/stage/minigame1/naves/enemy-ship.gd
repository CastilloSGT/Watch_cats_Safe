extends Area2D
export(int) var speed = 100
var motion = false

func _physics_process(delta: float) -> void:
	$AnimationPlayer.play("enemy_walk")
	if(motion):	
		position.x -= speed * delta
	else:
		position.x += speed * delta
		
	
func _on_enemyship_body_entered(body):
	Global.pacotes += 1
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	$NaveEnemy.set_flip_h(motion)
	motion = !motion
