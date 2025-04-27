extends CharacterBody2D
class_name PlayerController

@export var speed = 10.0
@export var jump_power = 10.0
@export var orbit_radius = 16.0  # << NEW: distance the gun orbits around the player

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var gun = $Gun  # << NEW: reference to your Gun node (must exist!)

func _input(event):
	# Handle jump.
	if event.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_power * jump_multiplier
	# Handle jump down
	if event.is_action_pressed("move_down"):
		set_collision_mask_value(10, false)
	else:
		set_collision_mask_value(10, true)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle movement input
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:           
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()

	# Orbit the gun around the player
	_orbit_gun()

func _orbit_gun():
	var mouse_pos = get_global_mouse_position()
	var dir = (mouse_pos - global_position).normalized()

	# Set the gun position in an orbit around the player
	gun.global_position = global_position + dir * orbit_radius

	# Make the gun face the mouse
	gun.rotation = dir.angle()

	# Optional: Flip the gun sprite if aiming left
	if dir.x < 0:
		gun.scale.y = -1
	else:
		gun.scale.y = 1
