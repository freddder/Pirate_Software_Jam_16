extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	animation.play("f_idle")
	move_and_slide()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("die"):
		print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
		animation.play("f_dead")
	
