extends Node2D

const chat = preload("res://src/ingame/stage/computador/pop-outs/chat.tscn")
const IDE = preload("res://src/ingame/stage/computador/pop-outs/IDE.tscn")
const lixo = preload("res://src/ingame/stage/computador/pop-outs/lixo.tscn")
const file = preload("res://src/ingame/stage/computador/pop-outs/file.tscn")
const browser = preload("res://src/ingame/stage/computador/pop-outs/browser.tscn")

var pop_out
var _position

func openModal():
	var chat = get_tree().get_nodes_in_group("chat").size() 
	var IDE = get_tree().get_nodes_in_group("IDE").size() 
	var lixo = get_tree().get_nodes_in_group("lixo").size() 
	var file = get_tree().get_nodes_in_group("file").size() 
	var browser = get_tree().get_nodes_in_group("browser").size() 
	
	# ABRE SÓ UM POP-OUT
	if(chat < 1 || IDE < 1 || lixo < 1 || file < 1  || browser < 1):
		var telinha = pop_out.instance()
		get_parent().add_child(telinha)
		telinha.position = _position.global_position
	
func _on_chat_pressed():
	_position = $icons/pos_chat
	pop_out = chat
	openModal()

func _on_IDE_pressed():
	_position = $icons/pos_IDE
	pop_out = IDE
	openModal()

func _on_lixo_pressed():
	_position = $icons/pos_lixo
	pop_out = lixo
	openModal()

func _on_file_pressed():
	_position = $icons/pos_file
	pop_out = file
	openModal()

func _on_browser_pressed():
	_position = $icons/pos_browser
	pop_out = browser
	openModal()
