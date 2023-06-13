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

func _ready():
	var name = self.name.replace("@", "").rstrip("0123456789") #n buga as cores
	
	match name:
		"Down":
			$LongSeta.modulate = Color("#629fd9")
		"Up":
			$LongSeta.modulate = Color("#6cd992")
		"Right":
			$LongSeta.modulate = Color("#d96c86")
		"Left":
			$LongSeta.modulate = Color("#c36cd9")

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
		perdePontos(true)

func queueArrowsbyPlayer():
	if sensorL:
		if Global.sensorLeft:
			if Input.is_action_pressed("ui_left"):
				animacao(true)
				
			if Input.is_action_just_released("ui_left"):
				animacaoStop()
				
	if sensorR:
		if Global.sensorRight:
			if Input.is_action_pressed("ui_right"):
				animacao(true)
				
			if Input.is_action_just_released("ui_right"):
				animacaoStop()
				
	if sensorU:
		if Global.sensorTop:
			if Input.is_action_pressed("ui_up"):
				animacao(true)
				
			if Input.is_action_just_released("ui_up"):
				animacaoStop()
				
	if sensorD:
		if Global.sensorDown:
			if Input.is_action_pressed("ui_down"):
				animacao(true)
			if Input.is_action_just_released("ui_down"):
				animacaoStop()

func queueArrowsbyEnemy():
	if sensorL:
		if Global.sensorLeft:
			animacao(false)

	if sensorR:
		if Global.sensorRight:
			animacao(false)

	if sensorU:
		if Global.sensorTop:
			animacao(false)

	if sensorD:
		if Global.sensorDown:
			animacao(false)

func animacao(win):
	new_id = self.get_instance_id()
	if(new_id == id_ant):
		stop = true
	
	$Seta.hide()
	if(Global.turno):
		$Brilho.show()
		$Brilho.global_position.y = 32
	
	$animation.play("destroi")
	yield($animation, "animation_finished")
	queue_free()
	
	if(win):
		ganhaPontos()

func animacaoStop():
	stop = false
	$animation.stop()
	
	$Seta.show()
	$Brilho.hide()
	
func perdePontos(left_the_screen):
	queue_free()
	if(Global.Score > -maxValue):
		if(left_the_screen):
			Global.Score -= 25
			Global.combo -= 1
		else:
			Global.Score -= 10
	
func ganhaPontos():
	if(Global.Score <= maxValue):
		Global.Score += 25
		if(!Global.maxCombo):
			Global.combo += 1


func _on_Left_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorL = true
	id_ant = self.get_instance_id()

func _on_Left_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorL = false

func _on_Up_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorU = true
	id_ant = self.get_instance_id()

func _on_Up_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorU = false

func _on_Right_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorR = true
	id_ant = self.get_instance_id()

func _on_Right_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorR = false

func _on_Down_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensorD = true
	id_ant = self.get_instance_id()

func _on_Down_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensorD = false
