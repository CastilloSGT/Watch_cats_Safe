extends Node2D

const chat = preload("res://src/ingame/stage/computador/pop-outs/chat.tscn")
const IDE = preload("res://src/ingame/stage/computador/pop-outs/IDE.tscn")
const lixo = preload("res://src/ingame/stage/computador/pop-outs/lixo.tscn")
const file = preload("res://src/ingame/stage/computador/pop-outs/file.tscn")
const browser = preload("res://src/ingame/stage/computador/pop-outs/browser.tscn")

var pop_out
var pop_out_name
var _position

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func openModal():
	var pop_out_group = get_tree().get_nodes_in_group(pop_out_name).size() 
	# ABRE SÓ UM POP-OUT
	if(pop_out_group < 1):
		var telinha = pop_out.instance()
		get_parent().add_child(telinha)
		telinha.position = _position.global_position
	
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
