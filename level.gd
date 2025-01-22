extends Node

var animals : Array[BaseAnimal] = []
#var golden_trees : Array[GodenTrees] = []

func find_closest_animal(global_position : Vector2) -> BaseAnimal:
	var smallest_distance = 9999999.9
	var closest_animal : BaseAnimal = null
	for animal in animals:
		var curr_distance = global_position.distance_to(animal.global_position)
		if animal.state_machine.get_current_state_name() != "grabbed" and curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_animal = animal
	return closest_animal

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
