extends KinematicBody2D
onready var animacao = $animation

# TIMER
onready var my_timer = get_node("Timer")

var wait_time = 0
var reduction = 0.2
var is_timer_running = false #sensor

func _physics_process(_delta: float) -> void:
	_on_Timer_timeout()
	animacao()

func animacao():
	pass

func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time > 0.0):
		my_timer.set_wait_time(wait_time)
		is_timer_running = true
	else:
		wait_time = 0
		is_timer_running = false
