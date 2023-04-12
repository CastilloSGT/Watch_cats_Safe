extends Node2D

onready var game1 = $Panel/game1
onready var game2 = $Panel/game2
onready var game3 = $Panel/game3
onready var game4 = $Panel/game4

func _on_game1_pressed():
	get_tree().change_scene("res://src/ingame/stage/minigame1/rat-attack.tscn")

func _on_game2_pressed():
	get_tree().change_scene("res://src/ingame/stage/minigame2/monkey-out.tscn")

func _on_game3_pressed():
	get_tree().change_scene("res://src/ingame/stage/minigame3/MuuGame.tscn")

func _on_game4_pressed():
	get_tree().change_scene("res://src/ingame/stage/minigame4/Quiz.tscn")
