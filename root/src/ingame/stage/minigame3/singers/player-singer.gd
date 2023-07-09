extends Node2D
onready var animation = $animation
const error = preload("res://src/ingame/stage/minigame3/arrows_move/little_error.tscn")

# TIMER
onready var my_timer = get_node("Timer")
var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

func _process(delta):
	animation()
	_on_Timer_timeout()

func animation():
	if(!is_timer_running):
		animation.play("idle")
	
	if(Global.turno):
		if(Input.is_action_just_pressed("ui_down")):
			if Global.sensorDown:
				animation.play("down")
				wait_time = 20
				addware_time(Color("#5b6ee1"))
			else:
				animation.play("down_fail")
				wait_time = 10
				
		if(Input.is_action_just_pressed("ui_up")):
			if Global.sensorTop:
				animation.play("up")
				wait_time = 10
				addware_time(Color("#37946e"))
			else:
				animation.play("up_fail")
				wait_time = 10
			
		if(Input.is_action_just_pressed("ui_left")):
			if Global.sensorLeft:
				animation.play("left")
				wait_time = 10
				addware_time(Color("#924196"))
			else:
				animation.play("left_fail")
				wait_time = 10
			
		if(Input.is_action_just_pressed("ui_right")):
			if Global.sensorRight:
				animation.play("right")
				wait_time = 10
				addware_time(Color("#ac3232"))
			else:
				animation.play("right_fail")
				wait_time = 10
				
		if (Global.maxCombo && Global.yes):
			animation.play("yes")
			wait_time = 10
			yield(animation,"animation_finished")
			Global.yes = false

func addware_time(color):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x = rng.randi_range(20,40)
	var y = rng.randi_range(180,190)
	
	var addware = error.instance()
	get_parent().add_child(addware)
	addware.modulate = color
	addware.position = Vector2(x,y)

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false
