extends Node2D

const games = preload("res://src/ingame/stage/computador/pop-outs/games.tscn")
const error = preload("res://src/ingame/stage/computador/pop-outs/error.tscn")

var pop_out
var pop_out_name
var _position

var error_on = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$icons/games/Games.frame = Global.fase
	
	if(Global.fase_concluida):
		games_load()
		
	if (Global.lost_count > 0):
		error_on = true

# ABRE POP - OUTS
func openModal():
	var telinha = pop_out.instance()
	get_parent().add_child(telinha)
	telinha.position = _position
	
func games_load():
	_position = $pos_games.global_position
	pop_out = games
	pop_out_name = "games"
	
	var pop_out_group = get_tree().get_nodes_in_group(pop_out_name).size() 
	# ABRE SÓ UM POP-OUT
	if(pop_out_group < 1):
		openModal()

func error():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var x = rng.randi_range(155,225)
	var y = rng.randi_range(75,125)
	
	_position = Vector2(x,y)
	pop_out = error
	
	var pop_out_group = get_tree().get_nodes_in_group("errors").size()
	if (pop_out_group < 5):	
		openModal()

func queueAll():
	var errors = get_tree().get_nodes_in_group("errors")
	if (errors.size() > 0):
		for error in errors:
			error.queue_free()

func _on_games_pressed():
	error_on = false
	queueAll()
	games_load()

func _on_quit_pressed():
	Global.lugar = "computador"
	error_on = false
	queueAll()
	get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")

func _on_error_timer_timeout():
	if (error_on):
		error()
