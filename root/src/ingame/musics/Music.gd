extends Node2D

onready var batids_menu = load("res://src/ingame/musics/musics/menu.ogg")
onready var batids_casa = load("res://src/ingame/musics/musics/casa.ogg")
var visblMus = Global.visibl 

func _ready():
	visib(visblMus)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func play_music(Scene, id):
	if id == 1 && Scene == false:
		$Menu.stream = batids_menu
		$Menu.play()
		Global.Telas = true
	elif id == 2 && Scene == true:
		$Menu.stream = batids_casa
		$Menu.play()
	else:
		#print(Global.Telas)
		pass
	#Global.Telas += 1
	#print(Global.Telas)
	
	 
func scens(bt):
	if bt == true:
		visib(bt)
	else:
		$Musics.stop()

func visib(x):
	if x == true:
		$Control.visible = x
		$TextureRect.visible = x
	else:
		$Control.visible = x
		$TextureRect.visible = x

func _on_Mute_toggled(button_pressed):
	AudioServer.set_bus_mute(0, !button_pressed)

func _on_btnVoltar_pressed():
	"""
	var temp = $myStreamPlayer2D.get_playback_position( )
	$myStreamPlayer2D.stop()
	$myStreamPlayer2D.play()
	$myStreamPlayer2D.seek(temp)
	"""
	visib(visblMus)
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://src/interface/menu.tscn")

func _on_ControleMusic_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)
