extends Node2D

var PRE_cadeado = preload("res://src/ingame/stage/minigame2/efeitos/cadeado.tscn").duplicate()
var y = 500
	
func invocar_lockes():
	var cadeado1 = PRE_cadeado.instance()
	get_parent().add_child(cadeado1)
	cadeado1.position = Vector2(40, y)

	var cadeado2 = PRE_cadeado.instance()
	get_parent().add_child(cadeado2)
	cadeado2.position = Vector2(80, y)
	
	var cadeado3 = PRE_cadeado.instance()
	get_parent().add_child(cadeado3)
	cadeado3.position = Vector2(120, y)
	
	var cadeado4 = PRE_cadeado.instance()
	get_parent().add_child(cadeado4)
	cadeado4.position = Vector2(160, y)
	
	var cadeado5 = PRE_cadeado.instance()
	get_parent().add_child(cadeado5)
	cadeado5.position = Vector2(200, y)


func _on_Timer_timeout():
	var lockies = get_tree().get_nodes_in_group("lockies")
	if(lockies.size() < 50):
		invocar_lockes()
