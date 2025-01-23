extends CharacterBody2D
class_name BaseEnemy

enum target_types {ANIMALS, TREES, CRYSTAL}

const target_type = target_types.ANIMALS

@onready var state_machine : StateMachine = $StateMachine
var target : CollisionObject2D = null

func _physics_process(delta):
	move_and_slide()

func get_hit(source : Vector2):
	print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
	state_machine.on_state_change(state_machine.current_state, "Dead")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	print("I have been freed")
	state_machine.on_state_change(state_machine.current_state, "Idle")

func chop_tree():
	print("I have chopped da tree")
	state_machine.on_state_change(state_machine.current_state, "")
