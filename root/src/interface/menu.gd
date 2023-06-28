extends Control
onready var btnStart = $menu/btn_start
onready var transition = get_node("transicao_foda/animation")

var entrou = false
var opts = false
var quit = false
#--------------------------------
func _ready():
	$transicao_foda.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	btnStart.grab_focus() #as
	Music.play_music(Global.Telas, 1)
	Global.Maps = 1
	
func _process(delta):
	if Input.is_action_pressed("ui_select"):
		if entrou:
			transition.play("in")
			yield(transition, "animation_finished")
			
			Global.Maps = 0
			Music.play_music(Global.Telas, 2)
			get_tree().change_scene("res://src/ingame/cenario/casa/quarto.tscn")
			
		elif opts:
			#Global.Maps = 1
			Music.scens(opts)
			get_tree().change_scene("res://src/ingame/musics/Music.tscn")
		elif quit:
			get_tree().quit()
		else:
			return;

func _on_btn_start_focus_entered():
	entrou = true

func _on_btn_start_focus_exited():
	entrou = false

func _on_btn_options_focus_entered():
	opts = true

func _on_btn_options_focus_exited():
	opts = false

func _on_btn_sair_focus_entered():
	quit = true

func _on_btn_sair_focus_exited():
	quit = false
