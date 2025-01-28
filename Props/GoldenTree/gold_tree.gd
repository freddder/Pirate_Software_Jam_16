extends CharacterBody2D
class_name GoldenTree

@onready var tree : CharacterBody2D = $"."
@onready var goldtree_animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var hit_counter = 3
#var timer : float = 0.0

func _ready():
	Level.golden_trees.push_back(self)

func get_hit(source : Vector2) -> bool:
	print("I got hit")
	goldtree_animation.play("tree_hit")
	if hit_counter == 0:
		get_rekt()
		return false
	else:
		hit_counter -= 1
		return true

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
