extends Node2D

const pop_out= preload("res://src/ingame/stage/computador/pop-out.tscn")
var _position

func openModal():
	var telinha = pop_out.instance()
	get_parent().add_child(telinha)
	telinha.position = _position.global_position
	
func _on_chat_pressed():
	_position = $icons/pos_chat
	openModal()

func _on_IDE_pressed():
	_position = $icons/pos_IDE
	openModal()

func _on_lixo_pressed():
	_position = $icons/pos_lixo
	openModal()


func _on_file_pressed():
	_position = $icons/pos_file
	openModal()

func _on_browser_pressed():
	_position = $icons/pos_browser
	openModal()
