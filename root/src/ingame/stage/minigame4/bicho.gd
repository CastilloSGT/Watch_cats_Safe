extends Area2D

var speed = 0.001
var canMove = true
var mouseIn = false
var canDestr = false

func _ready():
	speed = rand_range(0.001,0.003)

func _physics_process(delta):
	if canMove == true:
		look_at(get_parent().get_parent().get_node("Sprite").position)
		set_position(lerp(position, get_parent().get_parent().get_node("Sprite").position, speed))

	if position.x > get_parent().get_parent().get_node("Sprite").position.x:
		$TextureRect.flip_v = true
	
	if mouseIn and canDestr and Input.is_action_just_pressed("Click"):
		get_parent().get_parent().destVal -= 1
		get_parent().get_parent().pontos += 100
		queue_free()

func _on_Area2D_area_entered(area):
	if area.is_in_group("Sprite"):
		get_tree().change_scene_to(load("res://src/ingame/stage/minigame4/Quiz.tscn"))


func _on_TextureRect_mouse_entered():
	mouseIn = true


func _on_TextureRect_mouse_exited():
	mouseIn = false
