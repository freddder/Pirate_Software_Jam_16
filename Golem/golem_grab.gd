extends State
class_name GolemGrab

@onready var golem : CharacterBody2D = $"../.."
@onready var grab_hitbox : Area2D = $"../../Grab/Hitbox"
@export var grab_hitbox_speed : float = 400.0
@export var grab_max_range : float = 200.0
@export var grab_follow_speed : float = 200.0
var grab_hitbox_direction : Vector2
var grabbed_body : CharacterBody2D
var is_grabbing : bool = false
var is_attempting_grab : bool = false

func enter():
	if not is_grabbing:
		golem.velocity = Vector2.ZERO
		grab_hitbox.set_deferred("monitoring", true)
		grab_hitbox.position = Vector2.ZERO
		is_attempting_grab = true
		grab_hitbox_direction = (golem.get_global_mouse_position() - golem.global_position).normalized()
	else:
		is_grabbing = false

func exit():
	golem.grab_cooldown = 0.5
	grab_hitbox.set_deferred("monitoring", false)

func _process(delta):
	if grabbed_body:
		var distance = golem.get_global_mouse_position() - golem.global_position
		var body_global_destination : Vector2
		if distance.length() >= grab_max_range:
			body_global_destination = golem.global_position + distance.normalized() * grab_max_range
		else:
			body_global_destination = golem.get_global_mouse_position()
		
		var move_direction = (body_global_destination - grabbed_body.global_position)
		if move_direction.length() > 10:
			grabbed_body.global_position += move_direction.normalized() * grab_follow_speed * delta

func update(delta : float):
	if Level.scene != "map":
		grabbed_body.release()
	if is_attempting_grab:
		# Move grab hitbox until it finds something grabbable or it reaches max range
		grab_hitbox.global_position += grab_hitbox_direction * grab_hitbox_speed * delta
		if (grab_hitbox.global_position - golem.global_position).length() >= grab_max_range:
			ChangeState.emit(self, "free")
	elif !is_grabbing:
		grabbed_body.release()
		grabbed_body = null
		ChangeState.emit(self, "free")

func physic_update(delta : float):
	pass

func _on_grab_hitbox_body_entered(body):
	if body.is_in_group("grabbable") and is_grabbing == false:
		body.get_grabbed()
		grabbed_body = body
		is_grabbing = true
		is_attempting_grab = false
		ChangeState.emit(self, "free")
