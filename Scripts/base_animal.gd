extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	move_and_slide()
	
