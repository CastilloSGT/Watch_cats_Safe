extends Control
var is_paused = false setget set_is_paused
var res = false
var quit = false

var zero_cena = preload("res://src/utils/zero.tscn")
var um_cena = preload("res://src/utils/um.tscn")

onready var position_esq: Position2D = $Node2D/position2D
onready var position_dir: Position2D = $Node2D/positeste


onready var grabRes = $CenterContainer/VBoxContainer/BtnResume
onready var grabQuit = $CenterContainer/VBoxContainer/BtnStop


var dir: Node2D 
var esq: Node2D
var timer : Timer

func _ready():
	grabQuit.grab_focus()
	spawn_sprites()
	timer= Timer.new()
	timer.set_wait_time(5.0)
	timer.set_one_shot(false)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.start()

func spawn_sprites():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var num = rng.randi_range(0, 1)
	
	if num ==0:
			esq = um_cena.instance()
			dir = zero_cena.instance()
	else:
			esq = zero_cena.instance()
			dir = um_cena.instance()
			
	position_esq.add_child(esq)
	position_dir.add_child(dir)
	esq.set_global_position(position_esq.global_position)
	dir.set_global_position(position_dir.global_position)
	
func _on_timer_timeout():
	 spawn_sprites()
	
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
