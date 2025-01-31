extends State
class_name EnemyIdle

@onready var enemy : CharacterBody2D = $"../.."
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

@export var min_idle_time : float = 1.0
@export var max_idle_time : float = 4.0
var timer: float

func enter():
	collision.set_deferred("disabled", false)
	enemy.velocity = Vector2.ZERO
	timer = randf_range(min_idle_time, max_idle_time)
	var full_anim_name = enemy.anim_name_prefixes[enemy.target_type]
	if enemy.target_type == enemy.target_types.CRYSTAL and enemy.has_barrel:
		full_anim_name += "b"
	full_anim_name += "_idle"
	animation_player.play(full_anim_name)

func update(delta : float):
	timer -= delta
	if timer <= 0:
		ChangeState.emit(self, "follow")
