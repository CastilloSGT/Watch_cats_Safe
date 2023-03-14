extends Area2D

# muda sala :>
func _on_porta_body_entered(_body):
	Global.lugar = get_parent().name
	get_tree().change_scene("res://src/ingame/cenario/casa/"+ self.name +".tscn")
