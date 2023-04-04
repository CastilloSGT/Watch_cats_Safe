extends Area2D

var speed = 100
var sensor = false

func _process(delta):
	position.y -= speed * delta
	
	if position.y < -50:
		queue_free()
	if sensor:
		if Global.sensorDown:
			if Input.is_action_just_pressed("ui_down"):
				queue_free()

func _on_movearrow_down_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = true
	Global.sensorDown = true

func _on_movearrow_down_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = false
	Global.sensorDown = false
