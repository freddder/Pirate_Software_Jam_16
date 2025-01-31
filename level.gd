extends Node

@onready var explosion = load("res://Props/Explosion/explosion.tscn")
@onready var barrel = load("res://Props/ExplosiveBarrel/explosive_barrel.tscn")

var max_island_integrity: int = 10
var island_integrity: int = 10
var scene : String
var win_or_lose : bool = false
var master_volume : float = 10
var volume_setter : float
var base_volume : float = 10

var golem : Golem
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
		clear_arrays()
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

func clear_arrays():
	animals.clear()
	golden_trees.clear()
	crystals.clear()
	enemies.clear()

func create_barrel(global_position: Vector2, is_active: bool):
	var instance = barrel.instantiate()
	instance.is_active = is_active
	instance.global_position = global_position
	get_tree().current_scene.add_child(instance)

func create_explosion(global_position : Vector2):
	var instance = explosion.instantiate()
	instance.global_position = global_position
	get_tree().current_scene.add_child(instance)

func reduce_island_integrity(amount : int):
	island_integrity -= amount
	var level_ui = get_node("/root/Map/CanvasLayer")
	if level_ui:
		var percent = float(island_integrity) / float(max_island_integrity)
		level_ui.update_integrity_bar(percent)

func notify_enemy_spawn(spawn_position: Vector2):
	var level_ui : LevelUI = get_node("/root/Map/CanvasLayer")
	if level_ui:
		level_ui.add_spawn_warning(spawn_position)

func set_volume():
	volume_setter = base_volume * 0.1
	#print(volume_setter)

func does_tile_exist_at_position(position: Vector2) -> bool:
	var ground = get_node("/root/Map/NavigationRegion2D/Ground")
	if ground:
		var clicked_cell = ground.local_to_map(position)
		if ground.get_cell_tile_data(clicked_cell):
			return true
		else:
			return false
	else:
		return true

func check_if_game_over():
	if island_integrity < 1:
		# Lose game here
		win_or_lose = false
		scene = "lose"
		clear_arrays()
		get_tree().change_scene_to_file("res://win_or_lose.tscn")
		return
	
	if !enemies.is_empty():
		return # not over yet
	
	for ship in ships:
		if ship.has_enemies_left():
			return # not over yet
		
		if !ship.has_enemies_left() and enemies.is_empty():
			return
	
	# Win game here
	scene = "win"
	clear_arrays()
	get_tree().change_scene_to_file("res://win_or_lose.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
