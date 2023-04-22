extends CharacterBody2D


@export_enum("Duck", "Plankton") var type: String = "Duck"
# just for debug

enum States {
	IDLE,
	WALK_H,
	WALK_V,
	SHOOT,
	WALK_AND_SHOOT,
	DEATH,
	RESPAWNING,
}

const SPEED: float = 300.0

var current_state = States.IDLE


func _enter_tree():
	if type == "Duck":
		%Sprite.set_sprite_frames(load("res://resources/animations/AnimatedSprite2D/duck.tres"))
	elif type == "Plankton":
		%Sprite.set_sprite_frames(load("res://resources/animations/AnimatedSprite2D/plankton.tres"))


func _physics_process(_delta):
	var direction: Vector2 = Vector2(Input.get_axis("left", "right"), 
			Input.get_axis("up", "down"))
	
	if direction.x:
		velocity.x = direction.x * SPEED
		change_state(States.WALK_H)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction.y:
		velocity.y = direction.y * SPEED
		change_state(States.WALK_V)
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	if velocity == Vector2.ZERO:
		change_state(States.IDLE)
	
	move_and_slide()
	

func change_state(state: States) -> void:
	current_state = state
	update_animation()


func update_animation() -> void:
	match current_state:
		States.IDLE:
			%AnimationPlayer.play("player_movement/idle")
		States.WALK_H:
			%AnimationPlayer.play("player_movement/walk_h")
			flip_sprite()


func flip_sprite() -> void:
	if velocity.x < 0:
		%Sprite.set_flip_h(true)
	if velocity.x > 0:
		%Sprite.set_flip_h(false)
