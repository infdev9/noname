extends Node


func change_scene(scene: String) -> void:
	get_tree().change_scene_to_file(scene)


func quit() -> void:
	get_tree().quit()


#func load_data(data: String):
#	if !FileAccess.file_exists("res://data/" + data + ".json"):
#		print_debug("[ERROR] Cannot find datafile")
#		return
#
#	var file := FileAccess.open("res://data/" + data + ".json", FileAccess.READ)
#
#	var json: JSON
#
#	var error = json.parse(file.get_as_text())
#
#	if error == OK:
#		return json.get_data()
#	else:
#		print("[ERROR] JSON Parse Error: ", json.get_error_message(), " at line ", json.get_error_line())
