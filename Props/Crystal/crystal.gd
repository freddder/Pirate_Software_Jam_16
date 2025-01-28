extends CharacterBody2D
class_name Crystal

@onready var crystal_anim : AnimatedSprite2D = $AnimatedSprite2D
var hit_counter = 3

func _ready():
	Level.crystals.push_back(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_hit(source : Vector2) -> bool:
	print("CLANK")
	crystal_anim.play("c_hit")
	hit_counter -= 1
	if hit_counter == 0:
		get_rekt()
		return false
	else:
		return true

func get_rekt():
	print("My heart has been shattered")
	crystal_anim.play("c_broken")
	Level.reduce_island_integrity(1)
	Level.crystals.erase(self)
