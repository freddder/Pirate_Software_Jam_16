extends State
class_name grabbed

@onready var animal : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

func enter():
	animal.velocity = Vector2.ZERO
	collision.set_deferred("disabled", true)
