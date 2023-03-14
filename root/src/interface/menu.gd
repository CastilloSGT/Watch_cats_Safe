extends Control
onready var btnStart = $menu/btn_start
var entrou = 0

func _ready():
	btnStart.grab_focus()

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if (entrou == 1):
			get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")

func _on_btn_start_focus_entered():
	entrou = 1

func _on_btn_start_focus_exited():
	entrou = 0
