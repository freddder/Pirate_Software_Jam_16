extends State
class_name EnemyAttack

@onready var enemy : BaseEnemy = $"../.."
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"

var timer : float = 0.0

func enter():
	timer = 0.0

func exit():
	pass

func update(delta : float):
	if enemy.global_position.distance_to(enemy.target.global_position) > navigation_agent.target_desired_distance:
		ChangeState.emit(self, "follow")
		print("too far")
	
	timer += delta
	if timer > 1.0:
		if enemy.target:
			var is_target_alive = enemy.target.get_hit(enemy.global_position)
			if !is_target_alive:
				ChangeState.emit(self, "follow")
		timer = 0.0
