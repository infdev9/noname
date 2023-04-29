extends CharacterBody2D


@export_enum("Duck", "Plankton") var skin: String = "Duck"
@export_enum("Sniper", "Rifle", "Shotgun") var weapon: String = "Sniper"

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

var current_state := States.IDLE
var current_look := Looking.DOWN

var weapon_node: Sprite2D


func _enter_tree() -> void:
	match skin:
		"Duck":
			%Sprite.set_sprite_frames(load("res://resources/animations/AnimatedSprite2D/duck.tres"))
		"Plankton":
			%Sprite.set_sprite_frames(load("res://resources/animations/AnimatedSprite2D/plankton.tres"))
	
	match weapon:
		"Sniper":
			weapon_node = $Sniper
		"Rifle":
			weapon_node = $Rifle
		"Shotgun":
			weapon_node = $Shotgun
	weapon_node.show()


func _physics_process(_delta: float) -> void:
	var direction := Vector2(Input.get_axis(GLOBAL.ACTIONS.LEFT, GLOBAL.ACTIONS.RIGHT), 
			Input.get_axis(GLOBAL.ACTIONS.UP, GLOBAL.ACTIONS.DOWN))
	if direction.y:
		velocity.y = direction.y * GLOBAL.PLAYER_SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, GLOBAL.PLAYER_SPEED)
	if direction.x:
		velocity.x = direction.x * GLOBAL.PLAYER_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, GLOBAL.PLAYER_SPEED)

	if velocity == Vector2.ZERO:
		change_state(States.IDLE)
	else:
		change_state(States.WALK)

	move_and_slide()


func change_state(state: States) -> void:
	current_state = state
	update_animation()


func change_looking(direction: Looking) -> void:
	current_look = direction
	update_animation()


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


func look_to(angle: float) -> void:
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
	
	weapon_node.set_rotation_degrees(angle)
