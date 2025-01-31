extends CanvasLayer
class_name LevelUI

@onready var integrity_bar : TextureProgressBar = $IntegrityBar
@onready var warning_sign = load("res://Spirites/UI/spawn-warning.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	integrity_bar.value = integrity_bar.max_value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_integrity_bar(percentage: float):
	integrity_bar.value = integrity_bar.max_value * percentage

func add_spawn_warning(spawn_pos: Vector2):
	var new_sign = warning_sign.instantiate()
	new_sign.spawn_position = spawn_pos
	add_child(new_sign)
