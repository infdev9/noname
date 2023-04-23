extends Node


const TILE_SIZE: int = 384

func change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
	# enum of scenes
	

func quit() -> void:
	get_tree().quit()
	# safe quit 
