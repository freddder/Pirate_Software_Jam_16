extends Control

@onready var muuzik: AudioStreamPlayer = $"Menu Theme"
@onready var buttons: VBoxContainer = $ButtonsContainer
@onready var credits: ColorRect = $Credits
@onready var options: ColorRect = $Options
@onready var h2p: ColorRect = $H2P

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Level.set_volume()
	credits.visible = false
	options.visible = false
	h2p.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	muuzik.volume_db = Level.master_volume * Level.volume_setter
	if muuzik.volume_db > 10:
		muuzik.volume_db = 10

func _on_play_button_pressed():
	Level.scene = "map"
	Level.play_game()

func _on_credits_button_pressed():
	if credits.visible:
		buttons.visible = true
	else:
		buttons.visible = false
	credits.visible = !credits.visible

func _on_options_button_pressed():
	if options.visible:
		buttons.visible = true
	else:
		buttons.visible = false
	options.visible = !options.visible

func _on_h2p_button_pressed():
	if h2p.visible:
		buttons.visible = true
	else:
		buttons.visible = false
	h2p.visible = !h2p.visible

func _on_valume_changed(value: float) -> void:
	Level.master_volume = clamp(value, 1.0, 20.0)
	Level.volume_setter = Level.master_volume * 0.1
