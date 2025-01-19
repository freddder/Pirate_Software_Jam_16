extends State
class_name AnimalWander

@onready var animal : CharacterBody2D = $"../.."
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"

@export var wander_speed : float = 100.0

func enter():
	navigation_agent.target_position = Vector2(randf_range(-100, 100), randf_range(-100, 100)) + animal.global_position
	#print(navigation_agent.target_position)

func physic_update(delta : float):
	if navigation_agent.is_navigation_finished():
		ChangeState.emit(self, "Idle")
		return
	
	var direction = navigation_agent.get_next_path_position() - animal.global_position
	direction = direction.normalized()
	
	animal.velocity = direction * wander_speed
