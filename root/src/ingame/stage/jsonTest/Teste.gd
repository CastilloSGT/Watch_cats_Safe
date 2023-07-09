extends Node2D

func _ready():
	var st = read_json()
	#var json_string = JSON.stringify(read_json())
	#print(json_string)

func read_json():
	var f = File.new()
	var open_err = f.open("res://src/ingame/stage/jsonTest/Json/exam.json", File.READ)
	var json_object = JSON.new()
	var parse_err = json_object.parse(f.get_as_text())
	return json_object.get_data()
