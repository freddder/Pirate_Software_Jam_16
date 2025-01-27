extends State
class_name GolemFree

@onready var golem : CharacterBody2D = $"../.."
@onready var anim_player : AnimationPlayer = $"../../AnimationPlayer"
@onready var sprite : Sprite2D = $"../../Sprite2D"
@export var walk_speed = 150
var is_last_move_left : bool = false

func enter():
	anim_player.play("g_idle")

func exit():
	pass

func get_input():
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if input_direction == Vector2.ZERO: # not moving
		anim_player.play("g_idle")
	else:
		anim_player.play("g_walk")
		if input_direction.x < 0: # left
			is_last_move_left = true
		elif input_direction.x > 0: # right
			is_last_move_left = false
	
	sprite.flip_h = is_last_move_left
	golem.velocity = input_direction * walk_speed

func update(delta : float):
	pass

func physic_update(delta : float):
	get_input()
	golem.move_and_slide()
