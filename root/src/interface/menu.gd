extends Control
onready var btnStart = $menu/btn_start
var entrou = false
var opts = false

func _ready():
	btnStart.grab_focus()
	Music.play_music(1,Global.c)
	

func _process(delta):
	if Input.is_action_pressed("ui_accept"):
		if (entrou == true):
			get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")
		elif opts == true && entrou == false:
			Music.scens(2)
			get_tree().change_scene("res://src/ingame/musics/Music.tscn")
		else:
			return;
	

func _on_btn_start_focus_entered():
	entrou = true

func _on_btn_start_focus_exited():
	entrou = false

func _on_btn_options_focus_entered():
	opts = true

func _on_btn_options_focus_exited():
	opts = false
