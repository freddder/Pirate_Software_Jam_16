extends CharacterBody2D
class_name BaseEnemy

enum target_types {ANIMALS, TREES, CRYSTAL}
var target_type : target_types = target_types.ANIMALS
var has_barrel : bool = true
var spawn_position : Vector2

#@onready var ground : TileMapLayer = get_node("/root/Map/NavigationRegion2D/Ground")
@onready var body : CharacterBody2D = $"."
@onready var state_machine : StateMachine = $StateMachine
@onready var navi_agent : NavigationAgent2D = $NavigationAgent2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var target : CollisionObject2D = null
var health = 3

func _ready():
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
		anim_player.play("h_get_hit")
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	var is_on_valid_tile = Level.does_tile_exist_at_position(body.global_position)
	if is_on_valid_tile:
		state_machine.on_state_change(state_machine.current_state, "Idle")
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")
		
func attack_target():
	if target:
		if !target.get_hit(global_position, 1):
			target = null

func _on_animation_player_animation_finished(anim_name):
	if anim_name.ends_with("attack"):
		state_machine.on_state_change(state_machine.current_state, "idle")
	elif anim_name.ends_with("death"):
		Level.check_if_game_over()
		queue_free()
	elif anim_name.ends_with("get_hit"):
		anim_player.play("h_idle")
