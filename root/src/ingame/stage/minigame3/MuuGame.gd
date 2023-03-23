extends Node2D

const left = preload("res://src/ingame/stage/minigame3/CensSets/movearrow_left.tscn")
const up = preload("res://src/ingame/stage/minigame3/CensSets/movearrow_up.tscn")
const right = preload("res://src/ingame/stage/minigame3/CensSets/movearrow_right.tscn")
const down = preload("res://src/ingame/stage/minigame3/CensSets/movearrow_down.tscn")

var selectrandom_sets = 0 
var RNG = RandomNumberGenerator.new()

func _process(delta):
	$ScoreNode/lblScore.text = str(Global.Score)
	#as

func _on_Timer_timeout():
	$Control_spaw.start()
	RNG.randomize()
	var random_int = RNG.randi_range(0,4)
	var selectrandom_sets = random_int

	if selectrandom_sets == 1:
		var Left = left.instance()
		get_parent().add_child(Left)
		Left.position = $SpawArrow/Position_left.global_position

	if selectrandom_sets == 2:
		var Up = up.instance()
		get_parent().add_child(Up)
		Up.position = $SpawArrow/Position_up.global_position

	if selectrandom_sets == 3:
		var Right = right.instance()
		get_parent().add_child(Right)
		Right.position = $SpawArrow/Position_right.global_position

	if selectrandom_sets == 4:
		var Down = down.instance()
		get_parent().add_child(Down)
		Down.position = $SpawArrow/Position_down.global_position
