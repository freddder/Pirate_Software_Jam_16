extends Area2D

@onready var boom : AudioStreamPlayer2D = $boom
var scanned : bool = false
var timer : float = 0.0

func _ready():
	boom.volume_db = 3 * Level.volume_setter

func _process(delta):
	timer += delta
	if !scanned:
		for body in get_overlapping_bodies():
			var distance_to_center = (global_position - body.global_position).length()
			if distance_to_center < 129 and body.is_in_group("hittable"): # half the area radius
				body.get_hit(global_position, 5)
			elif body.is_in_group("scared"):
				body.get_hit(global_position, 0)
			scanned = true
		if Level.scene != "map":
			queue_free()
		Level.golem.shake_camera()
		
		if timer > 1.0:
			queue_free()
