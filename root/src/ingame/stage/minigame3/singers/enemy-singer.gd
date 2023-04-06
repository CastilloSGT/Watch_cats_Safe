extends Node2D
onready var animation = $animation

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
	
	if(!Global.turno):
		if Global.sensorDown:
			animation.play("down")
			wait_time = 10
				
		if Global.sensorTop:
			animation.play("up")
			wait_time = 10

		if Global.sensorLeft:
			animation.play("left")
			wait_time = 10
			
		if Global.sensorRight:
			animation.play("right")
			wait_time = 10

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false
