extends State
class_name EnemyFollow

@onready var enemy : BaseEnemy = $"../.."
@onready var sprite : Sprite2D = $"../../CollisionShape2D/Sprite"
@onready var navigation_agent : NavigationAgent2D = $"../../NavigationAgent2D"
@onready var animation_player : AnimationPlayer = $"../../AnimationPlayer"

@export var move_speed : float = 100.0
var timer : float = 0.0

func update_target_location():
	if enemy.target_type == enemy.target_types.ANIMALS:
		enemy.target = Level.find_closest_animal(enemy.global_position)
	elif enemy.target_type == enemy.target_types.TREES:
		enemy.target = Level.find_closest_tree(enemy.global_position)
	elif enemy.target_type == enemy.target_types.CRYSTAL:
		if enemy.has_barrel:
			enemy.target = Level.find_closest_crystal(enemy.global_position)
		else:
			enemy.target = null
			navigation_agent.target_position = enemy.spawn_position
	
	if enemy.target:
		navigation_agent.target_position = enemy.target.global_position
	else:
		navigation_agent.target_position = enemy.spawn_position

func enter():
	update_target_location()
	animation_player.play("h_walk")
	
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
	# Reached destination
	if enemy.global_position.distance_to(navigation_agent.target_position) < navigation_agent.target_desired_distance:
		if !enemy.target:
			enemy.queue_free()
		else:
			if enemy.target_type == enemy.target_types.CRYSTAL:
				Level.create_barrel(enemy.global_position)
				enemy.has_barrel = false
				ChangeState.emit(self, "idle")
			else:
				ChangeState.emit(self, "attack")
		return
	
	var direction = navigation_agent.get_next_path_position() - enemy.global_position
	direction = direction.normalized()
	
	sprite.flip_h = direction.x < 0
	
	enemy.velocity = direction * move_speed
