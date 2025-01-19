extends State
class_name AnimalWander

@onready var animal : CharacterBody2D = $"../.."
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"
@onready var animation : AnimatedSprite2D = $"../../AnimatedSprite2D"

@export var wander_speed : float = 100.0
var timer : float = 0

func enter():
	navigation_agent.target_position = Vector2(randf_range(-100, 100), randf_range(-100, 100)) + animal.global_position
	var direction = navigation_agent.get_next_path_position() - animal.global_position
	direction = direction.normalized()
	if direction.x > 0:
		animation.flip_h = true
		animation.play("f_walk_side")
	elif direction.x < 0:
		animation.flip_h = false
		animation.play("f_walk_side")
	#print(navigation_agent.target_position)

func exit():
	timer = 0.0

func update(delta : float):
	timer += delta
	if timer > 5.0:
		ChangeState.emit(self, "Idle")

func physic_update(delta : float):
	if navigation_agent.is_navigation_finished():
		ChangeState.emit(self, "Idle")
		return
	
	var direction = navigation_agent.get_next_path_position() - animal.global_position
	direction = direction.normalized()
	
	animal.velocity = direction * wander_speed
