extends State
class_name EnemyDeath

@onready var enemy : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

var timer : float = 0.0

func enter():
	enemy.velocity = Vector2.ZERO
	animated_sprite.play("e_dead")
	collision.set_deferred("disabled", true)
	#area.set_deferred("monitorable", false)
	#area.set_deferred("monitoring", false)

func update(delta : float):
	timer += delta
	if timer > 5.0:
		enemy.queue_free()
