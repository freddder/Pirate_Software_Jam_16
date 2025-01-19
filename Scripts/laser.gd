extends Node2D

const MAX_RANGE = 1000  # Laser's maximum length
var base_width = 22
var widthy = base_width
var shoot = false
@onready var collision = $Line2D/DamageArea/CollisionShape2D

func _ready():
	$Line2D.width = widthy  # Set initial laser width
	$Line2D.set_point_position(0, Vector2.ZERO)  # Ensure point 0 is at the origin

func _process(_delta):
	# Get the mouse position relative to the Area2D's global position
	var mouse_position = get_global_mouse_position() - global_position
	var max_cast_to = mouse_position.normalized() * MAX_RANGE
	
	# Update RayCast2D's target position
	$RayCast2D.target_position = max_cast_to

	# Handle laser drawing
	if $RayCast2D.is_colliding():
		var collision_point = $RayCast2D.get_collision_point()
		$Line2D.set_point_position(1, $Line2D.to_local(collision_point))
	else:
		$Line2D.set_point_position(1, max_cast_to)
	
	# Manage laser visibility and collision
	if shoot == true:
		var second_point_position = $Line2D.get_point_position(1)
		collision.shape.b = second_point_position
		collision.disabled = false
		$Line2D.visible = true
	else:
		collision.shape.b = Vector2.ZERO
		collision.disabled = true
		$Line2D.visible = false
  
	if Input.is_action_pressed("ui_select"):
		shoot = true
	else:
		shoot = false
