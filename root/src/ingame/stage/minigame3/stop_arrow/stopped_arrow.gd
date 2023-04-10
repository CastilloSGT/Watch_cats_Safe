extends Area2D

onready var animUp = $arrow_up/Stop_up_Anim
onready var animDown = $arrow_down/Stop_down_Anim
onready var animLeft = $arrow_left/Stop_left_Anim
onready var animRight = $arrow_right/Stop_right_Anim

var sensorL = false
var sensorR = false
var sensorU = false
var sensorD = false

onready var arrowName = self.name

func _process(delta):
	showArrows()
	if(Global.turno):
		marcaPontos()

func showArrows():
	match arrowName:
		"down_arrow":
			$arrow_down.show()
			$arrow_up.hide()
			$arrow_left.hide()
			$arrow_right.hide()
			
		"up_arrow":
			$arrow_down.hide()
			$arrow_up.show()
			$arrow_left.hide()
			$arrow_right.hide()
			
		"left_arrow":
			$arrow_down.hide()
			$arrow_up.hide()
			$arrow_left.show()
			$arrow_right.hide()
			
		"right_arrow":
			$arrow_down.hide()
			$arrow_up.hide()
			$arrow_left.hide()
			$arrow_right.show()

func marcaPontos():
	match arrowName:
		"down_arrow":
			if sensorD:
				if Input.is_action_just_pressed("ui_down"):
					animDown.play("Good_down")
					ganhaPontos()
			else:
				if Input.is_action_just_pressed("ui_down"):
					perdePontos()
					
		"up_arrow":
			if sensorU:
				if Input.is_action_just_pressed("ui_up"):
					animUp.play("Good_up")
					ganhaPontos()
			else:
				if Input.is_action_just_pressed("ui_up"):
					perdePontos()
					
		"left_arrow":
			if sensorL:
				if Input.is_action_just_pressed("ui_left"):
					animLeft.play("Good_left")
					ganhaPontos()
			else:
				if Input.is_action_just_pressed("ui_left"):
					perdePontos()
					
		"right_arrow":
			if sensorR:
				if Input.is_action_just_pressed("ui_right"):
					animRight.play("Good_right")
					ganhaPontos()
			else:
				if Input.is_action_just_pressed("ui_right"):
					perdePontos()
					
func ganhaPontos():
	Global.Score += 100
	if(!Global.maxCombo):
		Global.combo += 1
		
func perdePontos():
	Global.Score -= 100
	Global.combo = 0

# SENSORES 
func _on_left_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorL = true
func _on_left_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorL = false


func _on_right_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorR = true
func _on_right_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorR = false


func _on_up_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorU = true
func _on_up_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorU = false


func _on_down_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorD = true
func _on_down_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorD = false
