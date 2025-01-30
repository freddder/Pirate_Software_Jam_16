extends CharacterBody2D
class_name Crystal

@onready var crystal_glow : PointLight2D = $PointLight2D2
@onready var crystal_hit : AudioStreamPlayer2D = $chipped
@onready var shatter : AudioStreamPlayer2D = $shatter
@onready var crystal_anim : AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
var health = 3
var is_broken : bool = false

func _ready():
	Level.crystals.push_back(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func get_hit(source: Vector2, damage: int) -> bool:
	if is_broken:
		return false
	
	health -= damage
	if health > 0:
		crystal_hit.volume_db = randi_range(1, 3)
		crystal_hit.pitch_scale = randi_range(1, 3)
		crystal_hit.play()
		crystal_anim.play("c_hit")
		
		return true
	else:
		shatter.pitch_scale = randi_range(1, 3)
		shatter.play()
		crystal_glow.visible = !crystal_glow.visible
		crystal_anim.play("c_broken")
		Level.reduce_island_integrity(1)
		Level.crystals.erase(self)
		Level.check_if_game_over()
		is_broken = true
		return false

func _on_animated_sprite_2d_animation_finished():
	if crystal_anim.animation == "c_hit":
		crystal_anim.play("c_idle")
