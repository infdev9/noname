extends Control


func _on_play_pressed() -> void:
	Root.change_scene(GLOBAL.SCENES.GAME)


func _on_exit_pressed() -> void:
	Root.quit()
