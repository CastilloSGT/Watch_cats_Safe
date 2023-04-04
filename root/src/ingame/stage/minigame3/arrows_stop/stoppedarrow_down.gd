extends Area2D

onready var animp = $Stop_down_Anim
var sensor = false

func _process(delta):
	if sensor:
		if Input.is_action_just_pressed("ui_down"):
			animp.play("Good_down")
			Global.Score += 100
			if(!Global.maxCombo):
				Global.combo += 1
			
	else:
		if Input.is_action_just_pressed("ui_down"):
			Global.Score -= 100
			Global.combo = 0

func _on_stoppedarrow_down_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = true

func _on_stoppedarrow_down_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = false
