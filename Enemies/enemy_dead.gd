extends State
class_name EnemyDeath

@onready var enemy : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../CollisionShape2D/AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

var timer : float = 0.0

func enter():
	enemy.velocity = Vector2.ZERO
	animated_sprite.play("e_dead")
	collision.set_deferred("disabled", true)

func update(delta : float):
	timer += delta
	if timer > 5.0:
		enemy.queue_free()
