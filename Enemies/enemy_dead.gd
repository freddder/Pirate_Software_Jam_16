extends State
class_name EnemyDeath

@onready var enemy : CharacterBody2D = $"../.."
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var collision : CollisionShape2D = $"../../CollisionShape2D"

func enter():
	enemy.velocity = Vector2.ZERO
	animation_player.play("h_death")
	collision.set_deferred("disabled", true)
