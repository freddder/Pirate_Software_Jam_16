extends State
class_name Death

@onready var animal : CharacterBody2D = $"../.."
@onready var animated_sprite : AnimatedSprite2D = $"../../AnimatedSprite2D"
@onready var pathfinding_state = $".."

var is_running = true
var current_state

func _ready():
	animal.velocity = Vector2.ZERO

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("die"):
		play_death_animation()

func play_death_animation():
	animated_sprite.play("f_dead")
	animal.velocity = Vector2.ZERO
	is_active = false

	if pathfinding_state != null:
		is_running = false

func _process(delta):

	if !animated_sprite.is_playing() and !is_running:
		stop_state_machine()

func change_state(new_state):
	if !is_running:
		return
	if current_state != null:
		current_state.exit()
	current_state = new_state
	if current_state != null:
		current_state.enter()

func stop_state_machine():
	is_running = false
	if current_state == null:
		current_state.exit()
	current_state = null
