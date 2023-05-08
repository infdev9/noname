class_name Player
extends Character


func _ready() -> void:
	Root.append_gui_to_scene()


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
	
	angle = rad_to_deg(get_angle_to(get_global_mouse_position()))
