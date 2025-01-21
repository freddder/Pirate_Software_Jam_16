extends State
class_name GolemGrab

@onready var golem : CharacterBody2D = $"../.."
@onready var grab_hitbox : Area2D = $"../../Grab/Hitbox"
@export var grab_detection_speed : float = 10.0
@export var grab_max_range : float = 200.0
@export var grab_follow_speed : float = 10.0
var grabbed_body_relaive_position : Vector2
var grabbed_body : CharacterBody2D
var is_grabbing : bool = false
var is_attempting_grab : bool = false

func enter():
	golem.velocity = Vector2.ZERO
	grab_hitbox.set_deferred("monitoring", true)
	grab_hitbox.position = Vector2.ZERO
	is_attempting_grab = true

func exit():
	grab_hitbox.set_deferred("monitoring", false)

func grab_action():
	#for body in grab_hitbox.get_overlapping_bodies():
	#	if body.is_in_group("grabbed"):
	#		body.grab()
	#		grabbed_body = body
	#		is_grabbing = true
	#		grabbed_body_relaive_position = body.global_position - self.global_position
	#		return
	pass

func release_action():
	if grabbed_body and grabbed_body.is_in_group("grabbed"):
		grabbed_body.release()
		is_grabbing = false
		grabbed_body = null

func _process(delta):
	if grabbed_body:
		var distance = golem.get_global_mouse_position() - golem.global_position
		var body_global_destination : Vector2
		if distance.length() >= grab_max_range:
			body_global_destination = golem.global_position + distance.normalized() * grab_max_range
		else:
			body_global_destination = golem.get_global_mouse_position()
		
		var move_direction = (body_global_destination - grabbed_body.global_position).normalized()
		grabbed_body.global_position += move_direction * grab_follow_speed * delta
	

func physic_update(delta : float):
	pass
	#if !is_grabbing and Input.is_action_just_pressed("grab"):
	#	grab_action()
	#elif is_grabbing and Input.is_action_just_pressed("grab"):
	#	release_action()
