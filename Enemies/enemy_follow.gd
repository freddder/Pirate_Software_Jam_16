extends State
class_name EnemyFollow
enum target_types {ANIMALS, TREES, STONES}

const target_type = target_types.TREES

@onready var enemy : BaseEnemy = $"../.."
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"
@onready var sprite_animation : AnimatedSprite2D = $"../../AnimatedSprite2D"

@export var move_speed : float = 100.0
var timer : float = 0.0

func update_target_location():
	if target_type == target_types.ANIMALS:
		enemy.target = Level.find_closest_animal(enemy.global_position)
	elif target_type == target_types.TREES:
		enemy.target = Level.find_closest_tree(enemy.global_position)
	if enemy.target:
		navigation_agent.target_position = enemy.target.global_position

func enter():
	update_target_location()
	sprite_animation.play("e_walk")
	
func exit():
	timer = 0.0
	enemy.velocity = Vector2.ZERO

func update(delta : float):
	# Update the pathfinding every 2 seconds
	timer += delta
	if timer > 2.0:
		update_target_location()
		timer = 0.0

func physic_update(delta : float):
	if !enemy.target:
		enemy.velocity = Vector2.ZERO
		return
	
	if enemy.global_position.distance_to(enemy.target.global_position) < navigation_agent.target_desired_distance:
		ChangeState.emit(self, "attack")
		print("gotcha")
		return
	
	var direction = navigation_agent.get_next_path_position() - enemy.global_position
	direction = direction.normalized()
	
	sprite_animation.flip_h = direction.x > 0
	
	enemy.velocity = direction * move_speed
