extends State
class_name EnemyGrabbed

@onready var enemy : CharacterBody2D = $"../.."
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

func enter():
	enemy.velocity = Vector2.ZERO
	collision.set_deferred("disabled", true)
	var full_anim_name = enemy.anim_name_prefixes[enemy.target_type]
	if enemy.target_type == enemy.target_types.CRYSTAL and enemy.has_barrel:
		full_anim_name += "b"
	full_anim_name += "_grabbed"
	animation_player.play(full_anim_name)
