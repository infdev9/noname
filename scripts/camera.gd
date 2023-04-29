extends Camera2D


var target_pos := Vector2.ZERO
var tween: Tween


func _ready() -> void:
	set_global_position(%Player.get_global_position())
	reset_smoothing()
	target_pos = %Player.get_global_position()
	tween = create_tween()


func _physics_process(_delta: float) -> void:
	var player_pos: Vector2 = %Player.get_global_position()
	var direction: Vector2 = player_pos.direction_to(get_viewport().get_mouse_position())
	
	%Player.look_to(rad_to_deg(direction.angle()))
	
	move_camera(direction, player_pos)


func move_camera(direction: Vector2, to: Vector2) -> void:
	target_pos = to + direction * GLOBAL.TILE_SIZE * 3

	tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", target_pos, 0.08)
