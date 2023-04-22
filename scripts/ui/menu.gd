extends Control


func _on_play_pressed() -> void:
	Root.change_scene("res://scenes/game.tscn")


func _on_exit_pressed() -> void:
	Root.quit()
