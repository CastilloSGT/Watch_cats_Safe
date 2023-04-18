extends Node2D

var batids_menu = load("res://src/ingame/musics/musics/menu.ogg")
var visblMus = Global.visibl

func _ready():
	$Control.visible = false
	$TextureRect.visible = false

func play_music(x,c):
	if  Global.c == 1:
		$Musics.play()
		Global.c = 2
		print(Global.c)
	 
func scens(bt):
	if bt == true:
		visib(bt)
	else:
		$Musics.stop()

func _on_Mute_toggled(button_pressed):
	AudioServer.set_bus_mute(0, !button_pressed)

func visib(x):
	if x == true:
		$Control.visible = x
		$TextureRect.visible = x
	else:
		$Control.visible = x
		$TextureRect.visible = x

func _on_btnVoltar_pressed():
	"""
	var temp = $myStreamPlayer2D.get_playback_position( )
	$myStreamPlayer2D.stop()
	$myStreamPlayer2D.play()
	$myStreamPlayer2D.seek(temp)
	"""
	visib(visblMus)
	get_tree().change_scene("res://src/interface/menu.tscn")
