extends Area2D

onready var animp = $Stop_down_Anim
var sensor = false
#merda
func _process(delta):
	if sensor:
		if Input.is_action_just_pressed("ui_down"):
			animp.play("Good_down")
			Global.Score += 1

	if !sensor:
		if Input.is_action_just_pressed("ui_down"):
			animp.play("")

func _on_stoppedarrow_down_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = true

func _on_stoppedarrow_down_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = false
