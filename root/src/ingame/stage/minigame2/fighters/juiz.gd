extends Area2D

var direcao : Vector2
var get_enemy = false
var target

func _ready():
	target = Global.pos_enemy

func _process(delta):
	getPos(target)
	self.global_position = self.global_position.move_toward(target, 50 * delta)
	
func animacao():
	if direcao != Vector2.ZERO:
		$animation.play("idle")
	else:
		if(get_enemy):
			$animation.play("leavin")
		else:
			$animation.play("walk")

func getPos(target):
	var pos = self.global_position - target
	var posX
	var posY
	
	if(pos.x == 0):
		posX = 0
	else:
		posX = pos.x/abs(pos.x)
		
	if(pos.y == 0):
		posY = 0
	else:
		posY = pos.y/abs(pos.y)
		
	direcao = Vector2(posX,posY)
