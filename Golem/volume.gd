extends HSlider
@onready var volume_slider : HSlider = $"."

func _ready() -> void:
	volume_slider.value = Level.master_volume


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Level.volume_setter <= 0:
		Level.master_volume = 1
	if Level.volume_setter > 20:
		Level.master_volume = 20

func _on_value_changed(value: float) -> void:
	Level.master_volume = value
	Level.volume_setter = Level.master_volume * 0.1
	#print(Level.master_volume)
	#print(Level.volume_setter)
