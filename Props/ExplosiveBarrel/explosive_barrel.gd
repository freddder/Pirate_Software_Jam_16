extends CharacterBody2D
class_name ExplosiveBarrel

@onready var boombox : CharacterBody2D = $"."
@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var is_active : bool = false
var is_grabbed : bool = false
var timer : float = 6.0

func _ready():
	if is_active:
		anim_player.play("count_down")

func _process(delta):
	if !is_active or is_grabbed:
		return
		
	timer -= delta
	if timer < 0:
		explode()
	elif timer < 2.0:
		anim_player.speed_scale = 3
	elif timer < 4.0:
		anim_player.speed_scale = 2

func get_hit(source : Vector2, damage : int) -> bool:
	if is_grabbed:
		return true
	
	if is_active or damage >= 3:
		explode()
	else:
		anim_player.play("count_down")
		is_active = true
	return false

func get_grabbed():
	is_grabbed = true
	collision_shape.set_deferred("disabled", true)
	anim_player.pause()

func release():
	is_grabbed = false
	var is_on_valid_tile = Level.does_tile_exist_at_position(global_position)
	if is_on_valid_tile:
		collision_shape.set_deferred("disabled", false)
		anim_player.play()
	else:
		queue_free()

func explode():
	collision_shape.set_deferred("disabled", true)
	Level.create_explosion(global_position)
	queue_free()
