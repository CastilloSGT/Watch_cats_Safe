extends Control
onready var btnStart = $menu/btn_start
var entrou = false

func _ready():
	btnStart.grab_focus()

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if (entrou == true):
			get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")

func _on_btn_start_focus_entered():
	entrou = true

func _on_btn_start_focus_exited():
	entrou = false
