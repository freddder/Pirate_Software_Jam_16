extends State
class_name EnemyAttack

@onready var enemy : BaseEnemy = $"../.."
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"

func enter():
	animation_player.play("h_attack")

func exit():
	pass
