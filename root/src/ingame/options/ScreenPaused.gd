extends Control

var is_paused = false setget set_is_paused

func _unhandled_input(event):
	if event.is_action_pressed("paused"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		self.is_paused = !is_paused
#SLC CASH - SSD

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
