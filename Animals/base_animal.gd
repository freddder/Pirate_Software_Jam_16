extends CharacterBody2D
class_name BaseAnimal

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var scared_state : AnimalScared = $StateMachine/Scared

func _ready():
	Level.animals.push_back(self)

func _physics_process(delta):
	move_and_slide()

func get_hit(source: Vector2) -> bool: # Return if it is still alive
	print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
	state_machine.on_state_change(state_machine.current_state, "Death")
	return false

func scare(source: Vector2):
	scared_state.last_scare_source = source
	state_machine.on_state_change(state_machine.current_state, "Scared")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	state_machine.on_state_change(state_machine.current_state, "Idle")
