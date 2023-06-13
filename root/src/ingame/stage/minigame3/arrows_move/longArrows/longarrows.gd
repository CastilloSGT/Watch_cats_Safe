extends Area2D

var speed = 100
var sensorL = false
var sensorR = false
var sensorU = false
var sensorD = false

var id_ant = 0
var new_id = 0

var maxValue = 100
var stop = false

func _process(delta):
	queueArrowsbyPosition(delta)
	
	if(Global.turno):
		queueArrowsbyPlayer()
	else:
		queueArrowsbyEnemy()

func queueArrowsbyPosition(delta):
	if(!stop):
		position.y -= speed * delta
	
	if position.y < -30:
		queue_free()
		perdePontos(true)

func queueArrowsbyPlayer():
	if sensorU:
		if Global.sensorTop:
			if Input.is_action_pressed("ui_up"):
				new_id = self.get_instance_id()
				
				if(new_id == id_ant):
					stop = true
				
				$Cima.frame = 2
				$animation.play("destroi")
				yield($animation, "animation_finished")
				ganhaPontos()
				queue_free()
				
			if Input.is_action_just_released("ui_up"):
				$animation.stop()
				$Cima.frame = 1
				stop = false

func queueArrowsbyEnemy():
	if sensorL:
		if Global.sensorLeft:
			perdePontos(false)

	if sensorR:
		if Global.sensorRight:
			perdePontos(false)

	if sensorU:
		if Global.sensorTop:
			if(self.get_instance_id() == id_ant):
				stop = true
			
			$animation.play("destroi")
			yield($animation, "animation_finished")		
			perdePontos(false)

	if sensorD:
		if Global.sensorDown:
			perdePontos(false)

func perdePontos(left_the_screen):
	queue_free()
	if(Global.Score > -maxValue):
		if(left_the_screen):
			Global.Score -= 50
			Global.combo -= 1
		else:
			Global.Score -= 10
	
func ganhaPontos():
	if(Global.Score <= maxValue):
		Global.Score += 50
		if(!Global.maxCombo):
			Global.combo += 1	

func _on_longarrow_up_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorU = true
	id_ant = self.get_instance_id()

func _on_longarrow_up_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorU = false
