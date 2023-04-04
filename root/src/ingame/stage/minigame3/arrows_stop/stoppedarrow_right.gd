extends Area2D

onready var animp = $Stop_right_Anim
var sensor = false

func _process(delta):
	if sensor:
		if Input.is_action_just_pressed("ui_right"):
			animp.play("Good_right")
			Global.Score += 1

	if !sensor:
		if Input.is_action_just_pressed("ui_right"):
			animp.play("")

func _on_stoppedarrow_right_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = true

func _on_stoppedarrow_right_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = false
