extends Area2D

onready var animUp = $arrow_up/Stop_up_Anim
onready var animDown = $arrow_down/Stop_down_Anim
onready var animLeft = $arrow_left/Stop_left_Anim
onready var animRight = $arrow_right/Stop_right_Anim

onready var arrowName = self.name
var maxValue = 100

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
	if(get_parent().get_parent().name == "player_arrows"): #nao brilha a outra seta
		match arrowName:
			"down_arrow":
				if Global.sensorDown:
					if Input.is_action_just_pressed("ui_down"):
						animDown.play("Good_down")
				else:
					if Input.is_action_just_pressed("ui_down"):
						perdePontos()
						
			"up_arrow":
				if Global.sensorTop:
					if Input.is_action_just_pressed("ui_up"):
						animUp.play("Good_up")
						
				else:
					if Input.is_action_just_pressed("ui_up"):
						perdePontos()
						
			"left_arrow":
				if Global.sensorLeft:
					if Input.is_action_just_pressed("ui_left"):
						animLeft.play("Good_left")
						
				else:
					if Input.is_action_just_pressed("ui_left"):
						perdePontos()
						
			"right_arrow":
				if Global.sensorRight:
					if Input.is_action_just_pressed("ui_right"):
						animRight.play("Good_right")
						
				else:
					if Input.is_action_just_pressed("ui_right"):
						perdePontos()

func perdePontos():
	if(Global.Score >= - maxValue):
		Global.Score -= 10
		Global.combo = 0

# SENSORES 
func _on_left_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorLeft = true
func _on_left_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorLeft = false

func _on_right_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorRight = true
func _on_right_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorRight = false

func _on_up_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorTop = true
func _on_up_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorTop = false

func _on_down_arrow_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorDown = true
func _on_down_arrow_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	Global.sensorDown = false
