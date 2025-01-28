extends StaticBody2D
class_name Crystal

@onready var crystal_anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
var health = 3

func _ready():
	Level.crystals.push_back(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_hit(source: Vector2, damage: int) -> bool:
	print("CLANK")
	health -= damage
	if health > 0:
		crystal_anim.play("c_hit")
		return true
	else:
		print("My heart has been shattered")
		collision.disabled = true
		crystal_anim.play("c_broken")
		Level.reduce_island_integrity(1)
		Level.crystals.erase(self)
		return false
