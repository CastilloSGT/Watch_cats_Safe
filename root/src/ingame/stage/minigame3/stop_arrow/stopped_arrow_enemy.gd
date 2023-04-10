extends Area2D
onready var arrowName = self.name

func _process(delta):
	showArrows()

func showArrows():
	match arrowName:
		"down_arrow":
			$arrow_down.show()
			$arrow_up.hide()
			$arrow_left.hide()
			$arrow_right.hide()
			
		"up_arrow":
			$arrow_down.hide()
			$arrow_up.show()
			$arrow_left.hide()
			$arrow_right.hide()
			
		"left_arrow":
			$arrow_down.hide()
			$arrow_up.hide()
			$arrow_left.show()
			$arrow_right.hide()
			
		"right_arrow":
			$arrow_down.hide()
			$arrow_up.hide()
			$arrow_left.hide()
			$arrow_right.show()

