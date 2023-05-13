extends Node


func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)


func get_current_scene() -> Node:
	return get_tree().get_current_scene()


func get_player() -> Player:
	return get_current_scene().player


func append_gui_to_scene() -> void:
	Gui.set_process_mode(Node.PROCESS_MODE_INHERIT)
	Gui.show()


func change_scene(scene: String) -> void:
	get_tree().change_scene_to_file(scene)


func quit() -> void:
	get_tree().quit()
