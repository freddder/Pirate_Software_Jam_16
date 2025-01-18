extends CharacterBody2D

@export var speed = 150
@onready var tilemap = $"../TileMap"

var current_dir = "none"
 
var tiles = []

func _ready():
	$Sprite2D.play("g_idle")
func player():
	pass

func get_input():
	var input_direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity = input_direction * speed
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity = input_direction * speed
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_anim(1)
		velocity = input_direction * speed
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_anim(1)
		velocity = input_direction * speed
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0
	
func _physics_process(_delta):
	get_input()
	move_and_slide()

func play_anim(movement):
	var anim = $Sprite2D
	var dir = current_dir

	if dir == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("g_walk_side")
		elif movement == 0:
			anim.play("g_idle")
	if dir == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("g_walk_side")
		elif movement == 0:
			anim.play("g_idle")

	if dir == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("g_walk_up")
		elif movement == 0:
			anim.play("g_idle")
	if dir == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("g_walk_down")
		elif movement == 0:
			anim.play("g_idle")
