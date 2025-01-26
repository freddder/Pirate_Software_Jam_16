extends CharacterBody2D
class_name Trees

@onready var tree : CharacterBody2D = $"."
@onready var tree_animation : AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
var timer : float = 0.0

func get_hit(source : Vector2) -> bool:
	tree_animation.play("tree_chopped")
	return false

func update(delta : float):
	timer += delta
	#if timer > 5.0:
		#tree.queue_free()
