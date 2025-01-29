extends State
class_name grabbed

@onready var animal : BaseAnimal = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

func enter():
	animal.velocity = Vector2.ZERO
	animated_sprite.play(animal.anim_name_prefixes[animal.type] + "_float")
	collision.set_deferred("disabled", true)
