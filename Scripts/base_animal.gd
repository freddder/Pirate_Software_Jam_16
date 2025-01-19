extends CharacterBody2D

func _physics_process(delta):
	$AnimatedSprite2D.play("f_idle")
	move_and_slide()
	


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
