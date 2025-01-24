extends Area2D

var scanned : bool = false
var timer : float = 0.0

func _ready():
	pass

func _process(delta):
	timer += delta
	if !scanned:
		for body in get_overlapping_bodies():
			var distance_to_center = (global_position - body.global_position).length()
			if distance_to_center < 129 and body.is_in_group("hittable"): # half the area radius
				body.get_hit(global_position)
			elif body.is_in_group("scared"):
				body.scare(global_position)
			scanned = true
	
	if timer > 1.0:
		queue_free()
