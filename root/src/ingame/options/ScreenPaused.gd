extends Control

var is_paused = false setget set_is_paused

var res = false
var quit = false

var zero_cena = preload("res://src/utils/zero.tscn")
var um_cena = preload ("res://src/utils/um.tscn")
var position2D_node1: Position2D
var position2D_node2: Position2D

onready var grabRes = $CenterContainer/VBoxContainer/BtnResume
onready var grabQuit = $CenterContainer/VBoxContainer/BtnStop

func _ready():
	grabQuit.grab_focus()
	
	position2D_node1 = $Node2D/Position2D
	position2D_node2 = $Node2D/positeste
	invocar_Zero()
	invocar_Um()
	
func invocar_Zero():
	var zero_instance = zero_cena.instance()
	position2D_node1.add_child(zero_instance)
func invocar_Um():
	var um_instance = um_cena.instance()
	position2D_node2.add_child(um_instance)
		
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if res:
			_on_BtnResume_pressed()
		elif quit:
			_on_BtnStop_pressed()
		
		else:
			return;

func _unhandled_input(event):
	if Global.Maps == 1:
		Global.Maps = 1
	else:
		if event.is_action_pressed("paused"):
		
			grabQuit.grab_focus()
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
