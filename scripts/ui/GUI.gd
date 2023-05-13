class_name GUI
extends CanvasLayer


func _physics_process(_delta: float) -> void:
	var player = Root.get_player() as Player
	$Control/HUD/Ammo.set_text("%s/%s" % [player.weapon.ammo, player.weapon.max_ammo])
	
	if player.weapon.is_working:
		$Control/HUD/Ammo.label_settings.font_color.a = 1
	else:
		$Control/HUD/Ammo.label_settings.font_color.a = 0.5


func show_interactable_object(object: String) -> void:
	match object:
		"TV":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nначать игру")
		"Wardrobe":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nсменить скин")
		"Table":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nсменить ник")
		"Door":
			$Control/HUD/Clue.set_text("Нажмите I, чтобы\nвыйти")


func hide_interactable_object() -> void:
	$Control/HUD/Clue.set_text("")
