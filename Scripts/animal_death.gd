extends State
class_name Death

@onready var animal : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"
@onready var area : Area2D = $"../../Area2D"

var timer : float = 0.0

func enter():
	animal.velocity = Vector2.ZERO
	animated_sprite.play("f_dead")
	collision.set_deferred("disabled", true)
	area.set_deferred("monitorable", false)
	area.set_deferred("monitoring", false)

func update(delta : float):
	timer += delta
	if timer > 5.0:
		animal.queue_free()
