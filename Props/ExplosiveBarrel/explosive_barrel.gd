extends CharacterBody2D
class_name ExplosiveBarrel

@onready var collision_shape : CollisionShape2D = $CollisionShape2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func get_hit(source : Vector2, damage : int) -> bool:
	explode()
	return false

func get_grabbed():
	collision_shape.disabled = true

func release():
	collision_shape.disabled = false

func explode():
	print("BOOM")
	collision_shape.disabled = true
	Level.create_explosion(global_position)
