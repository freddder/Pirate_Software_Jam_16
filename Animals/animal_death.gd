extends State
class_name AnimalDeath

@onready var animal : BaseAnimal = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"
#@onready var area : Area2D = $"../../Area2D"

var timer : float = 0.0

func enter():
	animal.velocity = Vector2.ZERO
	animated_sprite.play(animal.anim_name_prefixes[animal.type] + "_dead")
	collision.set_deferred("disabled", true)
	Level.animals.erase(animal)
	Level.reduce_island_integrity(1)
	#area.set_deferred("monitorable", false)
	#area.set_deferred("monitoring", false)

func update(delta : float):
	timer += delta
	if timer > 5.0:
		Level.check_if_game_over()
		animal.queue_free()
