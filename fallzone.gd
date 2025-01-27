extends Area2D

@onready var fall_area : CollisionPolygon2D = $CollisionShape2D
var bodies = CharacterBody2D

func _on_body_entered(bodies) -> void:
	if bodies.is_in_group("hittable"):
		bodies.get_hit(fall_area.global_position)
