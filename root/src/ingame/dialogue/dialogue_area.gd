extends Area2D

onready var entrou = 0
onready var dialogo = $caixa

func _physics_process(_delta: float) -> void:
	if entrou == 1:
		$caixa/Background.show()
		$caixa.play()
	else:
		$caixa/Background.hide()
			

func _on_dialogue_area_area_entered(area):
	entrou = 1

func _on_dialogue_area_area_exited(area):
	entrou = 0
	
