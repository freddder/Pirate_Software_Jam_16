extends State
class_name GolemFree

@onready var golem : CharacterBody2D = $"../.."
@onready var animation : AnimatedSprite2D = $"../../AnimatedSprite2D"
@export var walk_speed = 150
var desired_direction : Vector2 = Vector2.ZERO
var is_last_move_left : bool = false

func enter():
	animation.play("g_idle")

func exit():
	animation.play("g_idle")

func get_input():
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if input_direction == Vector2.ZERO: # not moving
		animation.play("g_idle")
	else:
		animation.play("g_walk_side")
		if input_direction.x < 0: # left
			is_last_move_left = true
		elif input_direction.x > 0: # right
			is_last_move_left = false
	
	animation.flip_h = is_last_move_left
	golem.velocity = input_direction * walk_speed

func update(delta : float):
	pass

func physic_update(delta : float):
	get_input()
	golem.move_and_slide()
