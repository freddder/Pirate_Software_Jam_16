extends Node
class_name StateMachine

@export var initial_state : State

var current_state : State
var states : Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.ChangeState.connect(on_state_change)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physic_update(delta)

func get_current_state_name() -> String:
	return states.find_key(current_state)

func on_state_change(state, new_state_name : String):
	if state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
