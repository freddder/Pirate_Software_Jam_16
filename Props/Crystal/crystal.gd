extends StaticBody2D
class_name Crystal

func _ready():
	Level.crystals.push_back(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_hit(source : Vector2) -> bool:
	print("CLANK *gets destroyed*")
	Level.crystals.erase(self)
	return false
