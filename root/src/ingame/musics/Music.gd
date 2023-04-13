extends Node2D

var batids_menu = load("res://src/ingame/musics/musics/menu.ogg")

func _ready():
	pass
	 
func play_music(botas):
	$Musics.stream = batids_menu
	$Musics.play()
	if botas == 1:
		$Control.visible = false
		$TextureRect.visible =false
	else:
		$Musics.stop()

func _on_Mute_toggled(button_pressed):
	AudioServer.set_bus_mute(0, !button_pressed)


func _on_btnVoltar_pressed():
	get_tree().change_scene("res://src/interface/menu.tscn")
