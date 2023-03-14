extends Area2D

var onarea = false
		
func hackeando():
	get_tree().change_scene("res://src/ingame/stage/minigame1/rat-attack.tscn")

func _physics_process(_delta: float) -> void:
	if(Input.is_action_just_pressed("ui_select")):
		if (onarea == true):
			hackeando()
	
func _on_computador_body_exited(body):
	onarea = false
	
func _on_computador_body_entered(body):
	onarea = true
