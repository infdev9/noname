class_name Sniper
extends Weapon


const BULLET: PackedScene = preload("res://prefabs/Weapons/Bullet.tscn")
const LASER_SPRITE: CompressedTexture2D = preload("res://assets/sprites/weapons/laser.png")


func _enter_tree() -> void:
	super()
	cooldown = 1
	reload_time = 2
	recoil = 0.5
	bullet_acceleration = 1500
	bullet_lifetime = 10
	ammo_in_magazine = 99999
	ammo = ammo_in_magazine


func shoot():
	if try_spend_ammo(1):
		rebound()
		
		var bullet: Bullet = BULLET.instantiate()
		bullet._init(bullet_lifetime, Vector2(1, 0.2))
		bullet.get_node("Sprite").set_texture(LASER_SPRITE)
		bullet.set_position($BulletsSpawnPos.get_global_position())
		bullet.set_rotation(rotation)
		bullet.set_axis_velocity(Vector2.from_angle(rotation) * bullet_acceleration)
		Root.get_current_scene().get_node("Bullets").add_child(bullet)
		
		wait_cooldown()

