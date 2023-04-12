extends Node2D

func _physics_process(_delta: float) -> void:
	$AnimationPlayer.play("animation")


func _on_Menu_pressed():
	get_tree().change_scene("res://src/ingame/stage/computador/tela-computador.tscn")
