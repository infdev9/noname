class_name Sniper
extends Weapon


func _enter_tree() -> void:
	super()
	cooldown = 0.1
	reload_time = 4
	recoil = 1
	bullet_acceleration = 0
	bullet_lifetime = 0
	ammo_in_magazine = 999
	ammo = ammo_in_magazine


func _on_laser_body_entered(body: Character) -> void:
	body.kill()


func shoot():
	if is_working and try_spend_ammo(1):
		get_parent().get_parent().is_blocked = true
		$AnimationPlayer.play("shoot")
		await $AnimationPlayer.animation_finished
		get_parent().get_parent().is_blocked = false
		
		wait_cooldown()
