extends CharacterBody2D
class_name BaseAnimal

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine : StateMachine = $StateMachine
@onready var scared_state : AnimalScared = $StateMachine/Scared
@onready var ground : TileMapLayer = get_node("/root/Map/NavigationRegion2D/Ground")
@onready var body : CharacterBody2D = $"."
var hit_counter = 2

func _ready():
	Level.animals.push_back(self)

func _physics_process(delta):
	move_and_slide()

func get_hit(source: Vector2) -> bool: # Return if it is still alive
	print("AHHHHH, IT HURTS, PLEASE STOOOOOP!!!!!")
	if hit_counter == 0:
		get_rekt()
		return false
	else:
		if state_machine.get_current_state_name() != "grabbed":
			hit_counter -= 1
			print(hit_counter)
		return true

func get_rekt():
	print("I dead now")
	state_machine.on_state_change(state_machine.current_state, "Death")

func scare(source: Vector2):
	scared_state.last_scare_source = source
	state_machine.on_state_change(state_machine.current_state, "Scared")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	var clicked_cell = ground.local_to_map(body.get_global_position())
	var data = ground.get_cell_tile_data(clicked_cell)
	if data:
		state_machine.on_state_change(state_machine.current_state, "Idle")
		#print("tile exists")
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")
		return false
		#print("tile doesnt exists")
		#print(body)
