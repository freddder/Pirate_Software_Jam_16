extends StaticBody2D
class_name RegularTree

@onready var tree : StaticBody2D = $"."
@onready var tree_animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
var timer : float = 0.0

@onready var health = 3
@onready var tree_sound : AudioStreamPlayer2D = $timber
var base_volume : float = 5

func _ready():
	Level.register_integrity_entity(self)

func get_hit(source: Vector2, damage: int) -> bool:
	if health <= 0:
		return false
	
	health -= damage
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
		tree_animation.play("tree_fall")
		Level.reduce_island_integrity(Level.regular_tree_integrity_value)
		Level.check_if_game_over()
		return false
