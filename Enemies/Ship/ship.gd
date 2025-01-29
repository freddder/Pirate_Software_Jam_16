extends Node2D
class_name Ship

#class EnemySpawnData:
#	var quantity : int = 0
#	var type : BaseEnemy.target_types = BaseEnemy.target_types.ANIMALS
#	var time : float = 0.0

# x = enemy type
# y = quantity
# z = time in seconds
@export var timers : Array[Vector3i] = []

@onready var enemy = preload("res://Enemies/enemy.tscn")
var pending_spawn : Array[int] = []
var timer : float = 0.0
var spawn_cooldown : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	for entry in timers:
		if timer < entry.z:
			continue
		# Add entries to pending spawn
		for i in range(entry.y):
			pending_spawn.push_back(entry.x)
		timers.erase(entry)
	
	if spawn_cooldown > 0.0:
		spawn_cooldown -= delta
	elif !pending_spawn.is_empty():
		# Spawn dude
		var new_enemy = enemy.instantiate()
		if pending_spawn[0] == 0:
			new_enemy.target_type = BaseEnemy.target_types.ANIMALS
		elif pending_spawn[0] == 1:
			new_enemy.target_type = BaseEnemy.target_types.TREES
		else:
			new_enemy.target_type = BaseEnemy.target_types.CRYSTAL
		add_child(new_enemy)
		spawn_cooldown = 1.0
		pending_spawn.remove_at(0)
