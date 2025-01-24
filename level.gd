extends Node

var explosion = load("res://Props/Explosion/explosion.tscn")

var animals : Array[BaseAnimal] = []
var golden_trees : Array[GoldenTree] = []
var crystals : Array[Crystal] = []

func find_closest_animal(global_position : Vector2) -> BaseAnimal:
	var smallest_distance = 9999999.9
	var closest_animal : BaseAnimal = null
	for animal in animals:
		var curr_distance = global_position.distance_to(animal.global_position)
		if animal.state_machine.get_current_state_name() != "grabbed" and curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_animal = animal
	return closest_animal

func find_closest_tree(global_position : Vector2) -> GoldenTree:
	var smallest_distance = 9999999.9
	var closest_tree : GoldenTree = null
	for tree in golden_trees:
		var curr_distance = global_position.distance_to(tree.global_position)
		if curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_tree = tree
	return closest_tree

func find_closest_crystal(global_position : Vector2) -> Crystal:
	var smallest_distance = 9999999.9
	var closest_crystal : Crystal = null
	for crystal in crystals:
		var curr_distance = global_position.distance_to(crystal.global_position)
		if curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_crystal = crystal
	return closest_crystal

func create_explosion(global_position : Vector2):
	var instance = explosion.instantiate()
	instance.global_position = global_position
	add_child(instance)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
