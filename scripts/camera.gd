extends Camera2D


var target_pos := Vector2.ZERO
var tween: Tween


func _ready() -> void:
	set_global_position(%Player.get_global_position())
	reset_smoothing()
	target_pos = %Player.get_global_position()
	tween = create_tween()

func _process(_delta: float) -> void:
	var player_pos: Vector2 = %Player.get_global_position()
	var direction: Vector2 = get_global_position().direction_to(get_viewport().get_mouse_position())

	target_pos = player_pos + direction * Root.TILE_SIZE

	tween.kill()
	tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "global_position", target_pos, 0.1)

# Test camera implementation
