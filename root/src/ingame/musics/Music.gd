extends Node2D

var batids_menu = load("res://src/ingame/musics/musics/menu.ogg")

func _ready():
	pass
	
func play_music(botas):
	$Musics.stream = batids_menu
	if botas == 1:
		$Musics.play()
	else:
		$Musics.stop()
	
