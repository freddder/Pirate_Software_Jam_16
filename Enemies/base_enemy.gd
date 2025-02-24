extends CharacterBody2D
class_name BaseEnemy

enum target_types {ANIMALS, TREES, CRYSTAL}
var target_type : target_types = target_types.TREES
var anim_name_prefixes : Array[String] = ["h", "l", "m"]
var has_barrel : bool = true
var spawn_position : Vector2

@onready var state_machine : StateMachine = $StateMachine
@onready var navi_agent : NavigationAgent2D = $NavigationAgent2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var target : CollisionObject2D = null
var health = 3

func _ready():
	if target_type == target_types.ANIMALS:
		navi_agent.target_desired_distance = 30
	elif target_type == target_types.TREES:
		navi_agent.target_desired_distance = 50
	else:
		navi_agent.target_desired_distance = 80
	spawn_position = global_position
	Level.enemies.push_back(self)

func _physics_process(delta):
	move_and_slide()

func get_hit(source: Vector2, damage: int):
	health -= damage
	
	if target_type == target_types.CRYSTAL and has_barrel:
		Level.create_barrel(global_position, false)
		has_barrel = false
	
	if health > 0:
		state_machine.on_state_change(state_machine.current_state, "Idle")
		var full_anim_name = anim_name_prefixes[target_type] + "_get_hit"
		anim_player.play(full_anim_name)
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	var is_on_valid_tile = Level.does_tile_exist_at_position(global_position)
	if is_on_valid_tile:
		state_machine.on_state_change(state_machine.current_state, "Idle")
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")

func attack_target():
	if is_instance_valid(target):
		if !target.get_hit(global_position, 1):
			target = null

func _on_animation_player_animation_finished(anim_name):
	if anim_name.ends_with("attack"):
		state_machine.on_state_change(state_machine.current_state, "idle")
	elif anim_name.ends_with("death"):
		Level.check_if_game_over()
		queue_free()
	elif anim_name.ends_with("get_hit"):
		var full_anim_name = anim_name_prefixes[target_type] + "_idle"
		anim_player.play(full_anim_name)
