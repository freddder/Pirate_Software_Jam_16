extends CharacterBody2D
class_name GoldenTree

@onready var tree : CharacterBody2D = $"."
@onready var goldtree_animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var health = 3
@onready var tree_sound : AudioStreamPlayer2D = $timber
var base_volume : float = 5
#var timer : float = 0.0

func _ready():
	Level.golden_trees.push_back(self)

func get_hit(source: Vector2, damage: int) -> bool:
	print("I got hit")
	health -= damage
	if health > 0:
		tree_sound.pitch_scale = randi_range(2, 4)
		tree_sound.volume_db = base_volume * Level.volume_setter
		tree_sound.play()
		print(tree_sound.volume_db, "tree")
		print(Level.volume_setter)
		goldtree_animation.play("tree_hit")
		return true
	else:
		print("I got chopped")
		collision.disabled = true
		tree_sound.pitch_scale = 1
		tree_sound.volume_db = base_volume * Level.volume_setter
		tree_sound.play()
		print(tree_sound.volume_db, "tree")
		goldtree_animation.play("tree_falling")
		Level.reduce_island_integrity(1)
		Level.golden_trees.erase(self)
		return false

func update(delta : float):
	pass
	#timer += delta
	#if timer > 5.0:
		#tree.queue_free()
