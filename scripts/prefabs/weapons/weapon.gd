class_name Weapon
extends Sprite2D


const BASE_OFFSET_X = 84

var is_working: bool = true

var cooldown: float = 0.5
var reload_time: float = 1
var recoil: float = 0.4

var ammo: int = 9
var ammo_in_magazine: int = 10
var max_ammo: int = 100

var tween: Tween


func _init(weapon_ammo: int = ammo_in_magazine, weapon_max_ammo: int = 100) -> void:
	ammo = weapon_ammo
	max_ammo = weapon_max_ammo


func _input(event: InputEvent) -> void:
	if event.is_action(GLOBAL.ACTIONS.SHOOT):
		if is_working:
			shoot()


func shoot() -> void:
	pass


func try_spend_ammo(count: int) -> bool:
	if count <= ammo:
		ammo -= count
		return true
	else:
		reload()
		return false


func reload() -> void:
	ammo = ammo_in_magazine
	max_ammo -= ammo_in_magazine


func rebound() -> void:
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "offset:x", BASE_OFFSET_X * recoil, cooldown / 2)
	tween.tween_property(self, "offset:x", BASE_OFFSET_X, cooldown / 2)
	tween.tween_callback(tween.kill)


func _on_cooldown_timeout() -> void:
	is_working = true
