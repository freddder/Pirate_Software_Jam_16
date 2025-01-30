extends State
class_name GolemSlam

@onready var anim_player : AnimationPlayer = $"../../AnimationPlayer"

func enter():
	anim_player.play("g_slam")

func exit():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
