extends Node2D

func _ready():
	pass

func _ler():
	var data_to_send = ["a", "b", "c"]
	var json_string = JSON.stringify(data_to_send)
	# Save data
	# ...
	# Retrieve data
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_ARRAY:
			print(data_received) # Prints array
		else:
			print("Unexpected data")
else:
	print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())

