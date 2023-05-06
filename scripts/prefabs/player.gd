class_name Player
extends Character


func _physics_process(delta: float) -> void:
	move_by_input()
	super(delta)


func move_by_input() -> void:
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
