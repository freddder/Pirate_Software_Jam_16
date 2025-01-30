extends CharacterBody2D
class_name Golem

@onready var pow : AudioStreamPlayer2D = $Slam/pow
@onready var camera : Camera2D = $Camera2D
@onready var slam_hitbox : Area2D = $Slam/PunchZone
@onready var state_machine : StateMachine = $StateMachine
@onready var free_state : GolemFree = $StateMachine/Free
var grab_cooldown : float = 0.5

@export var shake_fade : float = 5.0
@export var shake_randomness : float = 15.0
var shake_strengh : float = 0.0

func get_input():
	if Input.is_action_pressed("laser") and state_machine.get_current_state_name() == "free":
		state_machine.on_state_change(free_state, "laser")
	
	if Input.is_action_just_pressed("grab") and grab_cooldown <= 0.0 and state_machine.get_current_state_name() == "free":
		state_machine.on_state_change(free_state, "grab")
	
	if Input.is_action_just_pressed("slam") and state_machine.get_current_state_name() == "free":
		slam_attack()

func _ready():
	Level.golem = self

func _process(delta):
	grab_cooldown -= delta
	
	if shake_strengh > 0:
		shake_strengh = lerpf(shake_strengh, 0, shake_fade * delta)
		camera.offset = Vector2(randf_range(-shake_strengh, shake_strengh), randf_range(-shake_strengh, shake_strengh))

func _physics_process(delta):
	get_input()

func shake_camera():
	shake_strengh = shake_randomness

func slam_attack():
	pow.volume_db = 3 * Level.volume_setter - 2
	print(pow.pitch_scale)
	pow.play()
	print(slam_hitbox.get_overlapping_bodies().size())
	for body in slam_hitbox.get_overlapping_bodies():
		if body.is_in_group("hittable"):
			body.get_hit(slam_hitbox.global_position, 1)

func _on_animation_player_animation_finished(anim_name):
	if anim_name.ends_with("fire"):
		state_machine.on_state_change(state_machine.current_state, "free")
