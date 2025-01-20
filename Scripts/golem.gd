extends CharacterBody2D

@export var walk_speed = 150

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
var desired_direction : Vector2 = Vector2.ZERO
var is_last_move_left : bool = false

@onready var laser_target : Node2D = $Laser/Explosion
@onready var laser_preview : Sprite2D = $Laser/Explosion/Preview
@onready var laser_raycast : RayCast2D = $Laser/RayCast2D
@onready var laser_hitbox : Area2D = $Laser/Explosion/Hitbox
#@export var laser_explosion_radius : float = 10.0
@export var laser_max_range : float = 300.0
var is_aiming_laser : bool = false

func _ready():
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
	velocity = input_direction * walk_speed
	
	if is_aiming_laser and !Input.is_action_pressed("laser"):
		fire_laser()
	
	is_aiming_laser = Input.is_action_pressed("laser")

func _process(delta):
	if is_aiming_laser:
		var distance = get_global_mouse_position() - self.global_position
		if distance.length() >= laser_max_range:
			laser_target.global_position = self.global_position + distance.normalized() * laser_max_range
		else:
			laser_target.global_position = get_global_mouse_position()
	
	laser_raycast.target_position = laser_target.position
	
	if laser_raycast.is_colliding():
		laser_target.global_position = laser_raycast.get_collision_point()

	laser_preview.visible = is_aiming_laser
	laser_preview.rotate(delta * deg_to_rad(30))

func _physics_process(_delta):
	get_input()
	move_and_slide()

func fire_laser():
	for body in laser_hitbox.get_overlapping_bodies():
		if body.is_in_group("die"):
			body.die()
