extends State
class_name GolemLaser

@onready var golem : Golem = $"../.."
@onready var laser_charge : AudioStreamPlayer2D = $"../../Laser/LaserCharge"
@onready var laser_blast : AudioStreamPlayer2D = $"../../Laser/LaserShoot"
@onready var laser_preview : Sprite2D = $"../../Laser/ExplosionPreview"
@onready var laser_beam : Sprite2D = $"../../Laser/Beam"
@onready var laser_raycast : RayCast2D = $"../../Laser/RayCast2D"
@onready var sprite : Sprite2D = $"../../Sprite2D"
@onready var anim_player : AnimationPlayer = $"../../AnimationPlayer"
@export var laser_max_range : float = 300.0
var is_aiming : bool = false
var is_firing : bool = false

func enter():
	anim_player.play("g_aiming")
	laser_charge.volume_db = 5 * Level.volume_setter
	laser_charge.play()
	is_aiming = true
	is_firing = false
	laser_preview.visible = true
	print(laser_charge.volume_db)

func exit():
	is_aiming = false
	is_firing = false

func toggle_beam():
	laser_beam.visible = !laser_beam.visible

func fire_laser():
	laser_blast.stop()
	Level.create_explosion(laser_preview.global_position)

func update(delta : float):
	if is_aiming:
		var distance = golem.get_global_mouse_position() - golem.global_position
		if distance.length() >= laser_max_range:
			laser_preview.global_position = golem.global_position + distance.normalized() * laser_max_range
		else:
			laser_preview.global_position = golem.get_global_mouse_position()
		sprite.flip_h = distance.x < 0
	
	laser_raycast.target_position = laser_preview.position
	
	if laser_raycast.is_colliding():
		laser_preview.global_position = laser_raycast.get_collision_point()
	
	laser_beam.rotation = (golem.get_global_mouse_position() - golem.global_position).normalized().angle()
	laser_beam.scale.x = 4 * golem.global_position.distance_to(laser_preview.global_position) / laser_beam.texture.get_width()
	
	laser_preview.visible = is_aiming
	laser_preview.rotate(delta * deg_to_rad(30))

func physic_update(delta : float):
	if is_aiming and !Input.is_action_pressed("laser") and !is_firing:
		laser_charge.stop()
		laser_blast.volume_db = 25 * Level.volume_setter
		laser_blast.volume_db = clamp(laser_blast.volume_db, 20, 27)
		print(laser_blast.volume_db)
		laser_blast.play()
		is_firing = true
		anim_player.play("g_fire")
	is_aiming = Input.is_action_pressed("laser") and !is_firing
