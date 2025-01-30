extends Node

@onready var explosion = load("res://Props/Explosion/explosion.tscn")
@onready var barrel = load("res://Props/ExplosiveBarrel/explosive_barrel.tscn")
@onready var ground : TileMapLayer = get_node("/root/Map/NavigationRegion2D/Ground")
var island_integrity: int = 10
var scene : String
var win_or_lose : bool = false
var master_volume : float = 10
var volume_setter : float
var base_volume : float = 10

var animals : Array[BaseAnimal] = []
var golden_trees : Array[GoldenTree] = []
var crystals : Array[Crystal] = []
var enemies : Array[BaseEnemy] = []
var ships : Array[Ship] = []

func play_game():
	if scene == "map":
		get_tree().change_scene_to_file("res://map.tscn")
		
func exit_game():
	if scene == "title":
		animals.clear()
		golden_trees.clear()
		crystals.clear()
		enemies.clear()
		get_tree().change_scene_to_file("res://Title_screen.tscn")

func find_random_animal() -> BaseAnimal:
	if !animals.is_empty():
		return animals.pick_random()
	else:
		return null

func find_closest_animal(global_position: Vector2) -> BaseAnimal:
	var smallest_distance = 9999999.9
	var closest_animal : BaseAnimal = null
	for animal in animals:
		var curr_distance = global_position.distance_to(animal.global_position)
		if curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_animal = animal
	return closest_animal

func find_random_golden_tree() -> GoldenTree:
	if !golden_trees.is_empty():
		return golden_trees.pick_random()
	else:
		return null

func find_closest_tree(global_position: Vector2) -> GoldenTree:
	var smallest_distance = 9999999.9
	var closest_tree : GoldenTree = null
	for tree in golden_trees:
		var curr_distance = global_position.distance_to(tree.global_position)
		if curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_tree = tree
	return closest_tree

func find_random_crystal() -> Crystal:
	if !crystals.is_empty():
		return crystals.pick_random()
	else:
		return null

func find_closest_crystal(global_position: Vector2) -> Crystal:
	var smallest_distance = 9999999.9
	var closest_crystal : Crystal = null
	for crystal in crystals:
		var curr_distance = global_position.distance_to(crystal.global_position)
		if curr_distance < smallest_distance:
			smallest_distance = curr_distance
			closest_crystal = crystal
	return closest_crystal

func create_barrel(global_position: Vector2, is_active: bool):
	var instance = barrel.instantiate()
	instance.is_active = is_active
	instance.global_position = global_position
	add_child(instance)

func create_explosion(global_position : Vector2):
	var instance = explosion.instantiate()
	instance.global_position = global_position
	add_child(instance)

func reduce_island_integrity(amount : int):
	island_integrity -= amount

func set_volume():
	volume_setter = base_volume * 0.1
	#print(volume_setter)

func does_tile_exist_at_position(position: Vector2) -> bool:
	var clicked_cell = ground.local_to_map(position)
	if ground.get_cell_tile_data(clicked_cell):
		return true
	else:
		return false

func check_if_game_over():
	if island_integrity < 10:
		# Lose game here
		return
	
	if !enemies.is_empty():
		return # not over yet
	
	for ship in ships:
		if ship.has_enemies_left():
			return # not over yet
	
	# Win game here

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
