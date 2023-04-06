extends Area2D
onready var arrowName = self.name

var speed = 100
var sensorL = false
var sensorR = false
var sensorU = false
var sensorD = false

func _process(delta):
	queueArrowsbyPosition(delta)
	
	if(Global.turno):
		queueArrowsbyPlayer()
	else:
		queueArrowsbyEnemy()

func queueArrowsbyPosition(delta):
	position.y -= speed * delta
	
	if position.y < -30:
		queue_free()
		Global.Score -= 50
		Global.combo -= 1

func queueArrowsbyPlayer():
	if sensorL:
		if Global.sensorLeft:
			if Input.is_action_just_pressed("ui_left"):
				queue_free()

	if sensorR:
		if Global.sensorRight:
			if Input.is_action_just_pressed("ui_right"):
				queue_free()

	if sensorU:
		if Global.sensorTop:
			if Input.is_action_just_pressed("ui_up"):
				queue_free()

	if sensorD:
		if Global.sensorDown:
			if Input.is_action_just_pressed("ui_down"):
				queue_free()

func queueArrowsbyEnemy():
	if sensorL:
		if Global.sensorLeft:
			queue_free()

	if sensorR:
		if Global.sensorRight:
			queue_free()

	if sensorU:
		if Global.sensorTop:
			queue_free()

	if sensorD:
		if Global.sensorDown:
			queue_free()
	
func _on_movearrow_left_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorL = true
	Global.sensorLeft = true
func _on_movearrow_left_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorL = false
	Global.sensorLeft = false


func _on_movearrow_right_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorR = true
	Global.sensorRight = true
func _on_movearrow_right_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorR = false
	Global.sensorRight = false
	

func _on_movearrow_up_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorU = true
	Global.sensorTop = true
func _on_movearrow_up_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorU = false
	Global.sensorTop = false


func _on_movearrow_down_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorD = true
	Global.sensorDown = true
func _on_movearrow_down_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorD = false
	Global.sensorDown = false
