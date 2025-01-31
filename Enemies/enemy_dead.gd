extends State
class_name EnemyDeath

@onready var enemy : CharacterBody2D = $"../.."
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

func enter():
	enemy.velocity = Vector2.ZERO
	var full_anim_name = enemy.anim_name_prefixes[enemy.target_type] + "_death"
	animation_player.play(full_anim_name)
	collision.set_deferred("disabled", true)
	Level.enemies.erase(enemy)
	Level.check_if_game_over()
