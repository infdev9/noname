class_name Character
extends CharacterBody2D


enum States {
	IDLE,
	WALK,
	DEATH,
	RESPAWNING,
}

enum Looking {
	UP,
	LEFT,
	RIGHT,
	DOWN,
}

enum Skins {
	PLANKTON,
	DUCK,
}

enum Weapons {
	NONE,
	SNIPER,
	RIFLE,
	SHOTGUN,
}

var angle: float

var current_state: States = States.IDLE
var current_look: Looking = Looking.DOWN
var current_weapon: Weapons = Weapons.NONE

var weapon := Weapon.new()


func _enter_tree() -> void:
	set_name(str(get_multiplayer_authority()))
	change_skin(Skins.PLANKTON)
	change_weapon(Weapons.NONE)


func _physics_process(_delta: float) -> void:
	if velocity == Vector2.ZERO:
		change_state(States.IDLE)
	else:
		change_state(States.WALK)
	look_to()
	move_and_slide()


func change_state(state: States) -> void:
	current_state = state
	update_animation()


func change_looking(direction: Looking) -> void:
	current_look = direction
	update_animation()


func change_skin(new_skin: Skins) -> void:
	match new_skin:
		Skins.DUCK:
			%Sprite.set_sprite_frames(load("res://resources/animations/AnimatedSprite2D/duck.tres"))
		Skins.PLANKTON:
			%Sprite.set_sprite_frames(load("res://resources/animations/AnimatedSprite2D/plankton.tres"))


func change_weapon(new_weapon: Weapons) -> void:
	update_weapon(new_weapon)
	rpc("remote_set_weapon", current_weapon)


func update_weapon(new_weapon: Weapons) -> void:
	weapon.queue_free()
	current_weapon = new_weapon
	match current_weapon:
		Weapons.NONE:
			weapon = load("res://prefabs/Weapons/Weapon.tscn").instantiate()
		Weapons.SNIPER:
			weapon = load("res://prefabs/Weapons/Sniper.tscn").instantiate()
		Weapons.RIFLE:
			weapon = load("res://prefabs/Weapons/Rifle.tscn").instantiate()
		Weapons.SHOTGUN:
			weapon = load("res://prefabs/Weapons/Shotgun.tscn").instantiate()
	%Weapon.add_child(weapon)


func update_animation() -> void:
	match current_state:
		States.IDLE:
			if current_look == Looking.UP:
				%AnimationPlayer.play("player_movement/idle_up")
			else:
				%AnimationPlayer.play("player_movement/idle")
				flip_sprite()
				
		States.WALK:
			if current_look == Looking.UP:
				%AnimationPlayer.play("player_movement/walk_up")
			else:
				%AnimationPlayer.play("player_movement/walk_h")
				flip_sprite()


func flip_sprite() -> void:
	if current_look == Looking.LEFT:
		%Sprite.set_flip_h(true)
	else:
		%Sprite.set_flip_h(false)


func look_to() -> void:
	if angle > GLOBAL.CAMERA_ANGLES.UP_LEFT and angle < GLOBAL.CAMERA_ANGLES.UP_RIGHT:
		change_looking(Looking.UP)
		%Sprite.set_z_index(1)
	elif angle > GLOBAL.CAMERA_ANGLES.DOWN_RIGHT and angle < GLOBAL.CAMERA_ANGLES.DOWN_LEFT:
		change_looking(Looking.DOWN)
		%Sprite.set_z_index(0)
	elif angle > GLOBAL.CAMERA_ANGLES.UP_RIGHT and angle < GLOBAL.CAMERA_ANGLES.DOWN_RIGHT:
		change_looking(Looking.RIGHT)
		%Sprite.set_z_index(0)
	elif abs(angle) > GLOBAL.CAMERA_ANGLES.DOWN_LEFT:
		change_looking(Looking.LEFT)
		%Sprite.set_z_index(0)
	
	weapon.set_rotation_degrees(angle)


func kill() -> void:
	hide()


func init_net(id: int) -> void:
	set_name(str(id))


@rpc("any_peer", "unreliable")
func remote_set_position(authority_position: Vector2) -> void:
	set_position(authority_position)


@rpc("any_peer", "unreliable")
func remote_set_angle(authority_angle: float) -> void:
	angle = authority_angle


@rpc("any_peer", "unreliable")
func remote_set_weapon(authority_weapon: Weapons) -> void:
	update_weapon(authority_weapon)


@rpc("any_peer", "unreliable")
func remote_weapon_shoot() -> void:
	weapon.shoot()
