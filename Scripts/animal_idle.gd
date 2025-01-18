extends State
class_name AnimalIdle

@export var animal : CharacterBody2D

@export var move_speed : float = 10.0
var move_dir : Vector2
var wander_time : float

func ransomize_wader():
	move_dir = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update(delta : float):
	if wander_time > 0:
		wander_time -= delta
	else:
		ransomize_wader()

func physic_update(delta : float):
	if animal:
		animal.velocity = move_dir * move_speed

func enter():
	ransomize_wader()
