extends Area2D

onready var animp = $Stop_right_Anim
var sensor = 0

func _process(delta):
	if sensor == 1:
		if Input.is_action_just_pressed("ui_right"):
			animp.play("Good_right")
			Global.Score += 1
			Global.teste = 1;

	if sensor == 0:
		if Input.is_action_just_pressed("ui_right"):
			animp.play()
			Global.teste = 3;

func _on_stoppedarrow_right_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1

func _on_stoppedarrow_right_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
