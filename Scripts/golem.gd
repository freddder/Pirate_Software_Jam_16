extends CharacterBody2D

@export var walk_speed = 150

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
var desired_direction : Vector2 = Vector2.ZERO

func _ready():
	animation.play("g_idle")

func get_input():
	var input_direction := Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	
	if input_direction == Vector2.ZERO: # not moving
		animation.play("g_idle")
	else:
		if input_direction.x > 0: # moving right
			animation.play("g_walk_side")
		elif input_direction.x < 0: # moving left
			animation.play("g_walk_side")
		else:
			if input_direction.y > 0: # moving straight up
				animation.play("g_walk_up")
			elif input_direction.y < 0: # moving straight down
				animation.play("g_walk_down")
	
	velocity = input_direction * walk_speed

func _physics_process(_delta):
	get_input()
	move_and_slide()
