extends CanvasLayer
class_name LevelUI

@onready var integrity_bar : TextureProgressBar = $IntegrityBar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_integrity_bar(percentage: float):
	integrity_bar.value = integrity_bar.max_value * percentage
	print("updated with " + str(integrity_bar.value))
