extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine

func _physics_process(delta):
	move_and_slide()

func die():
	print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
	state_machine.on_state_change(state_machine.current_state, "Death")

func grab():
	state_machine.on_state_change(state_machine.current_state, "grabbed")

func release():
	print("I have been freed")
	state_machine.on_state_change(state_machine.current_state, "AnimalIdle")
