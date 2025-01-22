extends State
class_name EnemyAttack

@onready var kill_zone : Area2D = $Threat_Range

func melee_attack():
	for body in kill_zone.get_overlapping_bodies():
		if body.is_in_group("die"):
			body.die()
