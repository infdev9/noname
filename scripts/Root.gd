extends Node


var gui: PackedScene = preload("res://prefabs/GUI.tscn")


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)


func get_current_scene() -> Node:
	return get_tree().get_current_scene()


func get_player() -> Player:
	return get_current_scene().get_node("Player")


func get_gui() -> GUI:
	return get_current_scene().get_node("GUI")


func append_gui_to_scene() -> void:
	get_current_scene().add_child.call_deferred(gui.instantiate())


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
