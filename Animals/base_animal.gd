extends CharacterBody2D
class_name BaseAnimal

@onready var fox_death_sfx : AudioStreamPlayer2D = $FoxDeathSFX
@onready var owl_death_sfx : AudioStreamPlayer2D = $OwlDeathSFX
@onready var hit_sfx : AudioStreamPlayer2D = $HitSFX
@onready var animated_sprite : AnimatedSprite2D = $CollisionShape2D/AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var scared_state : AnimalScared = $StateMachine/Scared
var health = 2

enum types {FOX, OWL}
var anim_name_prefixes : Array[String] = ["f", "o"]
var type : types

func _ready():
	type = randi() % types.size()
	Level.animals.push_back(self)

func _physics_process(delta):
	move_and_slide()

func get_full_anim_name(name: String) -> String:
	return anim_name_prefixes[type] + name

func get_hit(source: Vector2, damage: int) -> bool: # Return if it is still alive
	if state_machine.get_current_state_name() == "grabbed":
		return true
	
	if health <= 0:
		return false
	
	health -= damage
	if health > 0:
		scared_state.last_scare_source = source
		if damage == 0:
			state_machine.on_state_change(state_machine.current_state, "Scared")
		else:
			hit_sfx.play()
			state_machine.on_state_change(state_machine.current_state, "Idle")
			animated_sprite.play(anim_name_prefixes[type] + "_hit")
		return true
	else:
		hit_sfx.play()
		if type == types.FOX:
			fox_death_sfx.play()
		else:
			owl_death_sfx.play()
		state_machine.on_state_change(state_machine.current_state, "Death")
		return false

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	var is_on_valid_tile = Level.does_tile_exist_at_position(global_position)
	if is_on_valid_tile:
		state_machine.on_state_change(state_machine.current_state, "Idle")
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation.ends_with("hit"):
		state_machine.on_state_change(state_machine.current_state, "Scared")
