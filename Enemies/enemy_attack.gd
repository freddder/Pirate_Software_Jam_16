extends State
class_name EnemyAttack

@onready var enemy : BaseEnemy = $"../.."
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"

func enter():
	var full_anim_name = enemy.anim_name_prefixes[enemy.target_type] + "_attack"
	animation_player.play(full_anim_name)

func exit():
	pass
