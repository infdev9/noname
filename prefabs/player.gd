extends CharacterBody2D


const SPEED: float = 300.0

enum STATES {
	IDLE,
	WALK_HORIZONTAL,
	WALK_VERTICAL,
	SHOOT,
	WALK_AND_SHOOT,
	DEATH,
	RESPAWNING
}

var _current_state = STATES.IDLE


func _physics_process(delta):
	var direction: Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("", "ui_down"))
	
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	FlipSprite(direction.normalized().x)
	move_and_slide()


func FlipSprite(direction: int):
	if direction == -1:
		%Sprite.set_flip_h(true)
	if direction == 1:
		%Sprite.set_flip_h(false)
