class_name Bullet
extends RigidBody2D


var life_time: float


func _init(life_time: float) -> void:
	self.life_time = life_time


func _ready() -> void:
	$LifeTimer.start(life_time)


func _on_body_entered(body: CollisionObject2D) -> void:
	if body.get_collision_layer() == GLOBAL.COLLISION_LAYERS.WORLD:
		destroy()
	else:
		body.kill()


func destroy():
	$CollisionShape2D.set_disabled(true)
	
	var tween = create_tween()
	tween.tween_property($Sprite, "modulate:a", 0, 0.4)
	tween.tween_callback(queue_free)

