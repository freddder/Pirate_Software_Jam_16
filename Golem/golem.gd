extends CharacterBody2D

@onready var slam_hitbox : Area2D = $Slam/PunchZone
@onready var state_machine : StateMachine = $StateMachine
@onready var free_state : GolemFree = $StateMachine/Free
var grab_cooldown : float = 0.5

func get_input():
	if Input.is_action_pressed("laser") and state_machine.get_current_state_name() == "free":
		state_machine.on_state_change(free_state, "laser")
	
	if Input.is_action_just_pressed("grab") and grab_cooldown <= 0.0 and state_machine.get_current_state_name() == "free":
		state_machine.on_state_change(free_state, "grab")
	
	if Input.is_action_just_pressed("slam"):
		slam_attack()

func _process(delta):
	grab_cooldown -= delta
	pass

func _physics_process(delta):
	get_input()

func slam_attack():
	for body in slam_hitbox.get_overlapping_bodies():
		if body.is_in_group("hittable"):
			body.get_hit(slam_hitbox.global_position)

func _on_animation_player_animation_finished(anim_name):
	if anim_name.ends_with("fire"):
		state_machine.on_state_change(state_machine.current_state, "free")
