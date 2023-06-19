extends Node2D

var secretArray = [1,2,3,4]
var checkSecret : Array

func _ready() -> void:
	if Global.lugar != null:
		get_node("player").set_position(get_node(Global.lugar + "pos").position)
		
func _process(delta):
	if(checkSecret.size() < 4):
		if Input.is_action_just_pressed("ui_left"):
			checkSecret.append(1)
			
		if Input.is_action_just_pressed("soco"):
			checkSecret.append(2)
			
		if Input.is_action_just_pressed("u"):
			checkSecret.append(3)
			
		if Input.is_action_just_pressed("l"):
			checkSecret.append(4)
	else:
		if(checkSecret == secretArray):
			Global.secret = true
		else:
			checkSecret.clear()
