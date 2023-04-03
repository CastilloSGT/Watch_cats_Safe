extends Area2D

func _on_socoarea_body_entered(body):
	Global.area_enemy = true
	
func _on_socoarea_body_exited(body):
	Global.area_enemy = false
