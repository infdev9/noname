class_name GUI
extends CanvasLayer


func _physics_process(_delta: float) -> void:
	var player = Root.get_player() as Player
	$HUD/Ammo.set_text("%s/%s" % [player.weapon.ammo, player.weapon.max_ammo])
	
	if player.weapon.is_working:
		$HUD/Ammo.label_settings.font_color.a = 1
	else:
		$HUD/Ammo.label_settings.font_color.a = 0.5
