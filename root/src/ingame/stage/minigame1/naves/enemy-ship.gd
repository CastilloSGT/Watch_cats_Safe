extends Area2D

func _physics_process(_delta: float) -> void:
	$AnimationPlayer.play("enemy_idle")
	var inimigos_restantes = get_tree().get_nodes_in_group("enemies").size()
	
	if (inimigos_restantes == 1):
		get_tree().change_scene("res://src/interface/fim_prototipo.tscn")

func _on_enemyship_body_entered(body):
	queue_free()
