extends HSlider
@onready var music : AudioStreamPlayer = $"../../../../Music"


func _ready() -> void:
	music.volume_db = 8


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_value_changed(value: float) -> void:
	music.volume_db = value
	print(music.volume_db)
