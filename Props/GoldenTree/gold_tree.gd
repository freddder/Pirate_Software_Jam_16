extends CharacterBody2D
class_name GoldenTree

@onready var tree : CharacterBody2D = $"."
@onready var goldtree_animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision : CollisionShape2D = $CollisionShape2D
@onready var health = 3
#var timer : float = 0.0

func _ready():
	Level.golden_trees.push_back(self)

func get_hit(source: Vector2, damage: int) -> bool:
	print("I got hit")
	health -= damage
	if health > 0:
		goldtree_animation.play("tree_hit")
		return true
	else:
		print("I got chopped")
		collision.disabled = true
		goldtree_animation.play("tree_falling")
		Level.reduce_island_integrity(1)
		Level.golden_trees.erase(self)
		return false

func get_rekt():
	print("I got chopped")
	goldtree_animation.play("tree_falling")
	Level.reduce_island_integrity(1)
	Level.golden_trees.erase(self)
	
func update(delta : float):
	pass
	#timer += delta
	#if timer > 5.0:
		#tree.queue_free()
