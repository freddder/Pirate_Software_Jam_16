extends Camera2D
@onready var win_screen : Camera2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Level.win_or_lose == false:
		win_screen.visible = !win_screen.visible


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
