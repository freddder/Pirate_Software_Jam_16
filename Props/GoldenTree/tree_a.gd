extends CharacterBody2D

@onready var tree : CharacterBody2D = $"."
@onready var tree_animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
var timer : float = 0.0

@onready var health = 3
@onready var tree_sound : AudioStreamPlayer2D = $timber
var base_volume : float = 5
#var timer : float = 0.0

func _ready():
	print(health)

func get_hit(source: Vector2, damage: int) -> bool:
	if health <= 0:
		return false
	
	health -= damage
	print(health)
	
	if health > 0:
		tree_sound.pitch_scale = randi_range(2, 4)
		tree_sound.volume_db = base_volume * Level.volume_setter
		tree_sound.play()
		tree_animation.play("tree_hit")
		return true
	else:
		collision.disabled = true
		tree_sound.pitch_scale = 1
		tree_sound.volume_db = base_volume * Level.volume_setter
		tree_sound.play()
		tree_animation.play("tree_falling")
		return false
		
func update(delta : float):
	pass
	#timer += delta
	#if timer > 5.0:
		#tree.queue_free()
