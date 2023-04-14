extends Node2D
var count = 0

func _physics_process(_delta: float) -> void: 
	var qtdPop = get_tree().get_nodes_in_group("pop-outs").size()
	
	print(count)
	if(get_position() == Vector2(176,136)):
		count += 1
	#if(Global.msmPos == posAnterior):
	#	queue_free()
