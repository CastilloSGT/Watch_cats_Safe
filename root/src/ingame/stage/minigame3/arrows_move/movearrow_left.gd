extends Area2D

var speed = 100
var sensor = false

func _process(delta):
	position.y -= speed * delta
	
	if position.y < -30:
		queue_free()
		Global.Score -= 50
		Global.combo -= 1
	if sensor:
		if Global.sensorLeft:
			if Input.is_action_just_pressed("ui_left"):
				queue_free()

func _on_movearrow_left_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = true
	Global.sensorLeft = true

func _on_movearrow_left_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = false
	Global.sensorLeft = false
