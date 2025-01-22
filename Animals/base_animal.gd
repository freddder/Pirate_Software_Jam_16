extends CharacterBody2D
class_name BaseAnimal

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine

func _ready():
	Level.animals.push_back(self)

func _physics_process(delta):
	move_and_slide()

func get_hit():
	print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
	state_machine.on_state_change(state_machine.current_state, "Death")

func scare(source: Vector2):
	print("holy shit what was that")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	state_machine.on_state_change(state_machine.current_state, "Idle")
