extends Control
# Called when the node enters the scene tree for the first time.
func _physics_process(_delta: float) -> void:
	$VBoxContainer/btn_start.grab_focus()

func _on_btn_start_pressed():
	get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")
