extends Control

#REFATORAR QUANDO EU TIVER COM VONTADE (OU SENTIR VERGONHA DISSO)

var is_paused = false setget set_is_paused
var res = false
var quit = false
onready var grabRes = $CenterContainer/VBoxContainer/BtnResume
onready var grabQuit = $CenterContainer/VBoxContainer/BtnStop
#var cursor_alternativo = load("res://src/ingame/options/img/cursor.png")
#var vardeteste = load("res://src/ingame/options/img/CursorAz.png")

func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#Input.set_custom_mouse_cursor(cursor_alternativo)
	grabQuit.grab_focus()
	#Input.set_CUstom_mouse_cursor(vardeteste)
	#Input.set_custom_mouse_cursor(vardeteste)
	#grabQuit.grab_focus()
	
func _process(delta):
	#grabRes.grab_focus()
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_pressed("ui_select"):
		if res:
			_on_BtnResume_pressed()
			#self.is_paused = false
		elif quit:
			_on_BtnStop_pressed()
			#get_tree().quit()
		else:
			return;

func _unhandled_input(event):
	if Global.Maps == 1:
		Global.Maps = 1
	else:
		if event.is_action_pressed("paused"):
			#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			#grabQuit.flat = true
			#grabRes.flat = true
			grabQuit.grab_focus()
			#Input.set_custom_mouse_cursor(vardeteste)
			self.is_paused = !is_paused

func set_is_paused(value):
	if(is_paused):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused
	else:
		is_paused = value
		get_tree().paused = is_paused
		visible = is_paused

func _on_BtnResume_pressed():
	self.is_paused = false

func _on_BtnStop_pressed():
	get_tree().quit()

func _on_BtnResume_focus_entered():
	res = true

func _on_BtnResume_focus_exited():
	res = false

func _on_BtnStop_focus_entered():
	quit = true

func _on_BtnStop_focus_exited():
	quit = false
