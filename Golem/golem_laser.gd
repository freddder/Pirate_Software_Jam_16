extends State
class_name GolemLaser

@onready var golem : CharacterBody2D = $"../.."
@onready var laser_target : Node2D = $"../../Laser/Explosion"
@onready var laser_preview : Sprite2D = $"../../Laser/Explosion/Preview"
@onready var laser_raycast : RayCast2D = $"../../Laser/RayCast2D"
@onready var laser_hitbox : Area2D = $"../../Laser/Explosion/Hitbox"
#@export var laser_explosion_radius : float = 10.0
@export var laser_max_range : float = 300.0
var is_aiming : bool = false

func enter():
	is_aiming = true
	laser_preview.visible = true

func exit():
	is_aiming = false
	laser_preview.visible = false

func fire_laser():
	for body in laser_hitbox.get_overlapping_bodies():
		var distance_to_center = (laser_target.global_position - body.global_position).length()
		if distance_to_center < 129 and body.is_in_group("hittable"): # half the area radius
			body.die()
		elif body.is_in_group("scared"):
			body.scare(Vector2.ZERO)
	
	ChangeState.emit(self, "free")

func update(delta : float):
	if is_aiming:
		var distance = golem.get_global_mouse_position() - golem.global_position
		if distance.length() >= laser_max_range:
			laser_target.global_position = golem.global_position + distance.normalized() * laser_max_range
		else:
			laser_target.global_position = golem.get_global_mouse_position()
	
	laser_raycast.target_position = laser_target.position
	
	if laser_raycast.is_colliding():
		laser_target.global_position = laser_raycast.get_collision_point()
	
	laser_preview.rotate(delta * deg_to_rad(30))

func physic_update(delta : float):
	if is_aiming and !Input.is_action_pressed("laser"):
		fire_laser()
	is_aiming = Input.is_action_pressed("laser")
