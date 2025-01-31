extends Control
@onready var muuzik : AudioStreamPlayer = $"Menu Theme"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Level.set_volume()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	muuzik.volume_db = Level.master_volume * Level.volume_setter
	if muuzik.volume_db > 10:
		muuzik.volume_db = 10




func _on_menu_button_2_pressed() -> void:
	pass # Replace with function body.
