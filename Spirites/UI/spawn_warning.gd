extends TextureRect
class_name WarningImage

@onready var screen_size = get_viewport_rect().size  # Screen size
var spawn_position: Vector2
var timer : float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	if timer <= 0:
		queue_free()
		return
	
	var camera = get_viewport().get_camera_2d()
	if camera:
		var screen_pos = spawn_position - camera.global_position + get_viewport_rect().size / 2
		screen_pos = screen_pos.clamp(Vector2.ZERO, screen_size)
		visible = true
		position = screen_pos
