extends Node2D

func _physics_process(_delta: float) -> void:
	caixaAberta()
	
func caixaAberta():
	if(Global.areaOn == true):
		match Global.obj:
			"geladeira":
				$animation.play("geladeira")
			"tv":
				$animation.play("tv")
			"pia":
				$animation.play("pia")
			"chuveiro":
				$animation.play("chuveiro")
	else:
		$animation.play("RESET")
