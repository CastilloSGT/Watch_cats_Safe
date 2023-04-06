extends Area2D

var speed = 0.001
func _ready():
	speed = rand_range(0.001,0.005)

func _physics_process(delta):
	look_at(get_parent().get_parent().get_node("Sprite").position)
	set_position(lerp(position, get_parent().get_parent().get_node("Sprite").position, speed))

	if position.x > get_parent().get_parent().get_node("Sprite").position.x:
		$TextureReact.flip_v = true

func _on_Area2D_area_entered(area):
	if area.is_in_group("Sprite"):
		get_tree().change_scene_to(load("res://src/ingame/stage/minigame4/Quiz.tscn"))
