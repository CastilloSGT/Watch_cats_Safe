extends Node2D

const chat = preload("res://src/ingame/stage/computador/pop-outs/chat.tscn")
const IDE = preload("res://src/ingame/stage/computador/pop-outs/IDE.tscn")
const lixo = preload("res://src/ingame/stage/computador/pop-outs/lixo.tscn")
const file = preload("res://src/ingame/stage/computador/pop-outs/file.tscn")
const browser = preload("res://src/ingame/stage/computador/pop-outs/browser.tscn")

const games = preload("res://src/ingame/stage/computador/pop-outs/games.tscn")

var pop_out
var pop_out_name
var _position

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$icons/games/Games.frame = Global.fase
	
	if(Global.fase_concluida):
		games_load()

# ABRE POP - OUTS
func openModal():
	var pop_out_group = get_tree().get_nodes_in_group(pop_out_name).size() 
	# ABRE SÓ UM POP-OUT
	if(pop_out_group < 1):
		var telinha = pop_out.instance()
		get_parent().add_child(telinha)
		telinha.position = _position.global_position

func games_load():
	_position = $"pop-outs/pos_chat"
	pop_out = games
	pop_out_name = "games"
	openModal()
	
# se não forçar ele aparece sobre o cenario
func queue_pop_outs():
	var games = get_tree().get_nodes_in_group("games")
	for game in games:
		game.queue_free()
	
	var chats = get_tree().get_nodes_in_group("chat")
	for chat in chats:
		chat.queue_free()
		
	var IDEs = get_tree().get_nodes_in_group("IDE")
	for IDE in IDEs:
		IDE.queue_free()
		
	var lixos = get_tree().get_nodes_in_group("lixo")
	for lixo in lixos:
		lixo.queue_free()
		
	var files = get_tree().get_nodes_in_group("file")
	for file in files:
		file.queue_free()
		
	var browsers = get_tree().get_nodes_in_group("browser")
	for browser in browsers:
		browser.queue_free()
	
func _on_chat_pressed():
	_position = $"pop-outs/pos_chat"
	pop_out = chat
	pop_out_name = "chat"
	openModal()

func _on_IDE_pressed():
	_position = $"pop-outs/pos_IDE"
	pop_out = IDE
	pop_out_name = "IDE"
	openModal()

func _on_lixo_pressed():
	_position = $"pop-outs/pos_lixo"
	pop_out = lixo
	pop_out_name = "lixo"
	openModal()

func _on_file_pressed():
	_position = $"pop-outs/pos_file"
	pop_out = file
	pop_out_name = "file"
	openModal()

func _on_browser_pressed():
	_position = $"pop-outs/pos_browser"
	pop_out = browser
	pop_out_name = "browser"
	openModal()

func _on_games_pressed():
	games_load()

func _on_quit_pressed():
	Global.lugar = "computador"
	queue_pop_outs()
	get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")
