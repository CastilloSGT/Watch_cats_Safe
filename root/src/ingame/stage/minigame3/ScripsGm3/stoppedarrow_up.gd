extends Area2D

onready var animp = $Stop_up_Anim
var sensor = 0

func _process(delta):
	if sensor == 1:
		if Input.is_action_just_pressed("ui_up"):
			animp.play("Good_up")
			Global.Score += 1
			Global.teste = 1;

	if sensor == 0:
		if Input.is_action_just_pressed("ui_up"):
			animp.play("")
			Global.teste = 3;

func _on_stoppedarrow_up_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1

func _on_stoppedarrow_up_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
