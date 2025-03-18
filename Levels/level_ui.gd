extends CanvasLayer
class_name LevelUI

@onready var integrity_bar : TextureProgressBar = $IntegrityBar
@onready var warning_sign = load("res://Spirites/UI/spawn-warning.tscn")
@onready var pause_menu = $PauseMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	integrity_bar.value = integrity_bar.max_value
	pause_menu.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause_menu()

func update_integrity_bar(percentage: float):
	integrity_bar.value = integrity_bar.max_value * percentage

func add_spawn_warning(spawn_pos: Vector2):
	var new_sign = warning_sign.instantiate()
	new_sign.spawn_position = spawn_pos
	add_child(new_sign)

func toggle_pause_menu():
	pause_menu.visible = !pause_menu.visible

func _on_value_changed(value: float) -> void:
	Level.master_volume = clamp(value, 1.0, 20.0)
	Level.volume_setter = Level.master_volume * 0.1

func _on_main_menu_button_pressed():
	Level.scene = "title"
	Level.exit_game()
