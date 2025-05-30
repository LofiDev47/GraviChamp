extends CharacterBody2D
class_name PlayerController

# Movement Properties
@export var speed = 10.0
@export var jump_power = 10.0
@export var max_health := 3

var speed_multiplier = 30.0
var jump_multiplier = -30.0
var direction = 0
var background2 = 1
var current_health := max_health

# Physics
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	current_health = max_health  # Initialize health

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

	# Get the input direction
	direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed * speed_multiplier
	else:           
		velocity.x = move_toward(velocity.x, 0, speed * speed_multiplier)

	move_and_slide()

# Health System
func take_damage(amount: int):
	current_health -= amount
	if $AnimationPlayer:
		$AnimationPlayer.play("hurt_flash")  # Visual feedback
	
	if current_health <= 0:
		die()

func die():
	get_tree().reload_current_scene()  # Simple respawn
