extends Node


"""var data = {}

func save_game():
	data["image_path"] = $Sprite.texture.resource_path

	var file = File.new()
	var error = file.open("user://savegame.json", File.WRITE)
	if error == OK:
	   file.store_line(to_json(data))
	file.close()

func load_game():
	var file = File.new()
	var error = file.open("user://savegame.json", File.READ)
	if error == OK:
	   data = parse_json(file.get_line())
	file.close()

	$Sprite.texture = load(data["image_path"])"""
