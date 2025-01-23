extends State
class_name EnemyGrabbed

@onready var enemy : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../CollisionShape2D/AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

func enter():
	enemy.velocity = Vector2.ZERO
	collision.set_deferred("disabled", true)
