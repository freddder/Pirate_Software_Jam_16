extends State
class_name AnimalIdle

@onready var animal : BaseAnimal = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

@export var min_idle_time : float = 1.0
@export var max_idle_time : float = 3.0
var timer: float

func enter():
	collision.set_deferred("disabled", false)
	animal.velocity = Vector2.ZERO
	timer = randf_range(min_idle_time, max_idle_time)
	animated_sprite.play(animal.anim_name_prefixes[animal.type] + "_idle")

func update(delta : float):
	timer -= delta
	if timer <= 0:
		ChangeState.emit(self, "Wander")
