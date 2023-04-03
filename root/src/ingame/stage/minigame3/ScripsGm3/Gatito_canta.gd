extends KinematicBody2D

onready var animp = $Gatito_anim
onready var my_timer = get_node("GatitoControla") # get node reference

var teste = Global.teste

var stop_dont = false
var wait_time = 0.0
var reduction = 0.2

func _physics_process(delta):
	anim()
	print(wait_time)

func anim():
	if(Global.teste == 1 && stop_dont != true):
		animp.play("teste1")
		#wait_time = 2.0
	elif Global.teste == 2 && stop_dont != true:
		animp.play("teste2")
	elif Global.teste == 3 && stop_dont != true:
		animp.play("teste3")
		#wait_time = 3.0
	elif Global.teste == 4 && stop_dont != true:
		animp.play("teste4")
	else:
		my_timer.stop()
		animp.play("teste")
func _on_Timer_timeout():
	wait_time -= reduction
	
	if(wait_time >= 0.0):
		my_timer.set_wait_time(wait_time) # reference it here
		stop_dont = false;
	else:
		animp.play("teste")
		stop_dont = true;
