extends Area2D

onready var entrouArea = false
onready var bol = $Bol
onready var animation = $animation
onready var key = $Bol/Label

func _ready():
	bol.hide()
	key.hide()
	
func _physics_process(_delta: float) -> void:
	animation()

func animation():
	if Input.is_action_pressed("ui_accept") && entrouArea:
		Global.areaOn = true
		hideKey()
		
	match Global.obj:
		"cama":
			if Input.is_action_just_pressed("ui_right"):
				Global.areaOn = false
		"computador":
			if Input.is_action_just_pressed("ui_down") || Input.is_action_just_pressed("ui_left"):
				Global.areaOn = false

# LETRINHA FLUTUANDO
func showKey():
	key.show()
	animation.play("flutuati")
	
func createKey():
	bol.show()
	animation.play("apir")
	yield(animation,"animation_finished")
	showKey()
	
func hideKey():
	key.hide()
	animation.play("desapir")
	yield(animation,"animation_finished")
	bol.hide()

# VERIFICAÇÃO DE AREA
func _on_dialogue_area_area_entered(area):
	Global.obj = get_parent().name
	entrouArea = true
	createKey()
			
func _on_dialogue_area_area_exited(area):
	entrouArea = false
	hideKey()
