extends State
class_name ChopTree

@onready var chop_range : Area2D = $"../Attack/Threat_Range"
@onready var chop_animation : AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
var chop_counter = 0

func enter():
	chop_animation.play("e_chop")

func update(delta):
	chop_counter + 1
