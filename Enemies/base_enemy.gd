extends CharacterBody2D
class_name BaseEnemy

enum target_types {ANIMALS, TREES, CRYSTAL}
var target_type : target_types = target_types.ANIMALS
var has_barrel : bool = true
var spawn_position : Vector2

@onready var ground : TileMapLayer = get_node("/root/Map/NavigationRegion2D/Ground")
@onready var body : CharacterBody2D = $"."
@onready var state_machine : StateMachine = $StateMachine
@onready var navi_agent : NavigationAgent2D = $NavigationAgent2D
@onready var anim_player : AnimationPlayer = $AnimationPlayer
var target : CollisionObject2D = null

func _ready():
	spawn_position = global_position

func _physics_process(delta):
	move_and_slide()

func get_hit(source : Vector2):
	state_machine.on_state_change(state_machine.current_state, "Idle")
	anim_player.play("h_get_hit")

func get_grabbed():
	state_machine.on_state_change(state_machine.current_state, "Grabbed")

func release():
	var clicked_cell = ground.local_to_map(body.get_global_position())
	var data = ground.get_cell_tile_data(clicked_cell)
	if data:
		state_machine.on_state_change(state_machine.current_state, "Idle")
		print("tile exists")
	else:
		state_machine.on_state_change(state_machine.current_state, "Death")
		return false
		print("tile doesnt exists")
		print(body)
		
func attack_target():
	if target:
		target.get_hit(global_position)

func _on_animation_player_animation_finished(anim_name):
	if anim_name.ends_with("attack"):
		print("done attacking")
		state_machine.on_state_change(state_machine.current_state, "idle")
	elif anim_name.ends_with("death"):
		queue_free()
	elif anim_name.ends_with("get_hit"):
		anim_player.play("h_idle")
