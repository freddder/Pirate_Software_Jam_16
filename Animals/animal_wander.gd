extends State
class_name AnimalWander

@onready var animal : BaseAnimal = $"../.."
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"
@onready var sprite_animation : AnimatedSprite2D = $"../../AnimatedSprite2D"

@export var wander_speed : float = 100.0
var timer : float = 0

func enter():
	navigation_agent.target_position = Vector2(randf_range(-100, 100), randf_range(-100, 100)) + animal.global_position
	sprite_animation.play(animal.anim_name_prefixes[animal.type] + "_walk")

func exit():
	timer = 0.0

func update(delta : float):
	timer += delta
	if timer > 3.0:
		ChangeState.emit(self, "Idle")

func physic_update(delta : float):
	if navigation_agent.is_navigation_finished():
		ChangeState.emit(self, "Idle")
		return
	
	var direction = navigation_agent.get_next_path_position() - animal.global_position
	direction = direction.normalized()
	
	sprite_animation.flip_h = direction.x > 0
	
	animal.velocity = direction * wander_speed
