extends CharacterBody2D

func _physics_process(delta):
	$AnimatedSprite2D.play("f_idle")
	move_and_slide()
