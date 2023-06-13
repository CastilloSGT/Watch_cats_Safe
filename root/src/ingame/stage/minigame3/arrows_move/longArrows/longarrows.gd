extends Area2D

var speed = 100
var sensorL = false
var sensorR = false
var sensorU = false
var sensorD = false

var id_ant = 0
var new_id = 0

var stop = false

func _process(delta):
	queueArrowsbyPosition(delta)
	
	if(Global.turno):
		queueArrowsbyPlayer()
	#else:
	#	queueArrowsbyEnemy()

func queueArrowsbyPosition(delta):
	if(!stop):
		position.y -= speed * delta
	
	if position.y < -30:
		queue_free()
		#perdePontos(true)

func queueArrowsbyPlayer():
	if sensorU:
		if Global.sensorTop:
			if Input.is_action_pressed("ui_up"):
				new_id = self.get_instance_id()
				
				if(new_id == id_ant):
					stop = true
				
				$animation.play("destroi")
				yield($animation, "animation_finished")
				queue_free()

func _on_longarrow_up_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorU = true
	id_ant = self.get_instance_id()

func _on_longarrow_up_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorU = false
