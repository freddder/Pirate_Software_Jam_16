extends CharacterBody2D
class_name GoldenTree

@onready var tree : CharacterBody2D = $"."
@onready var goldtree_animation : AnimatedSprite2D = $AnimatedSprite2D
#var timer : float = 0.0

func _ready():
	Level.golden_trees.push_back(self)

func get_hit(source : Vector2) -> bool:
	print("I got chopped")
	goldtree_animation.play("tree_hit")
	return false

func update(delta : float):
	pass
	#timer += delta
	#if timer > 5.0:
		#tree.queue_free()
