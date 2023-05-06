class_name Rifle
extends Weapon


const BULLET: PackedScene = preload("res://prefabs/Weapons/Bullet.tscn")


func _enter_tree() -> void:
	cooldown = 0.3
	reload_time = 0.2
	recoil = 0.8


func shoot():
	if try_spend_ammo(1):
		rebound()
		
		var bullet: Bullet = BULLET.instantiate()
		bullet._init(10)
		bullet.set_position($BulletsSpawnPos.get_position())
		bullet.add_constant_force(Vector2.RIGHT*10000)
		$Bullets.add_child(bullet)
		
		is_working = false
		%Cooldown.start(cooldown)
