extends CharacterBody2D
class_name ExplosiveBarrel

@onready var collision_shape : CollisionShape2D = $CollisionShape2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var is_active : bool = false
var timer : float = 6.0

func _ready():
	pass # Replace with function body.

func _process(delta):
	if !is_active:
		return
	
	timer -= delta
	if timer < 0:
		explode()
	elif timer < 2.0:
		anim_player.speed_scale = 3
	elif timer < 4.0:
		anim_player.speed_scale = 2

func get_hit(source : Vector2, damage : int) -> bool:
	if is_active or damage >= 3:
		explode()
	else:
		anim_player.play("count_down")
		is_active = true
	return false

func get_grabbed():
	collision_shape.disabled = true
	anim_player.pause()

func release():
	collision_shape.disabled = false
	anim_player.play()

func explode():
	collision_shape.disabled = true
	Level.create_explosion(global_position)
	queue_free()
