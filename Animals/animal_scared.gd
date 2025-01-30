extends State
class_name AnimalScared

@onready var animal : BaseAnimal = $"../.."
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"
@onready var sprite_animation : AnimatedSprite2D = $"../../CollisionShape2D/AnimatedSprite2D"

@export var run_speed : float = 200.0
@export var run_distance : float = 200.0
var last_scare_source : Vector2
var timer : float = 0

func enter():
	navigation_agent.target_position = (animal.global_position - last_scare_source).normalized() * run_distance + animal.global_position
	sprite_animation.play(animal.anim_name_prefixes[animal.type] + "_walk")

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
	
	sprite_animation.flip_h = direction.x > 0
	
	animal.velocity = direction * run_speed
