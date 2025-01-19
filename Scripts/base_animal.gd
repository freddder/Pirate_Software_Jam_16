extends CharacterBody2D

func _physics_process(delta):
	$AnimatedSprite2D.play("f_idle")
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("die"):
		print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
		queue_free()
	
