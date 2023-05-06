class_name Bullet
extends RigidBody2D


var life_time: float


func _init(bullet_life_time: float = 1) -> void:
	life_time = bullet_life_time


func _ready() -> void:
	$LifeTimer.start(life_time)


func _on_body_entered(body: Node2D) -> void:
	if body is TileMap:
		destroy()
	elif body is Character and not body is Player:
		body.kill()


func _on_life_timer_timeout() -> void:
	destroy()


func destroy():
	$CollisionShape2D.set_disabled(true)
	
	var tween = create_tween()
	tween.tween_property($Sprite, "modulate:a", 0, 0.4)
	tween.tween_callback(queue_free)



