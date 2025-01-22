extends State
class_name EnemyIdle

@onready var enemy : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

@export var min_idle_time : float = 1.0
@export var max_idle_time : float = 4.0
var timer: float

func enter():
	print("idle")
	collision.set_deferred("disabled", false)
	enemy.velocity = Vector2.ZERO
	timer = randf_range(min_idle_time, max_idle_time)
	animated_sprite.play("e_idle")

func update(delta : float):
	timer -= delta
	if timer <= 0:
		ChangeState.emit(self, "follow")
