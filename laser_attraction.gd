extends Area2D
class_name Laser

# Configuration
@export var speed := 600.0
@export var pull_force := 150.0
@export var lifetime := 2.0
@export var damage := 1

# State
var is_pulling := false
var pulled_bodies := []

func _ready():
	# Web-safe initialization
	$Timer.wait_time = lifetime
	$Timer.start()
	
	# Connect signals safely
	if $Timer:
		$Timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	if is_pulling:
		_process_pull_mode(delta)
	else:
		position += transform.x * speed * delta

func _process_pull_mode(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy") and body not in pulled_bodies:
			var dir = (global_position - body.global_position).normalized()
			body.velocity += dir * pull_force * delta
			pulled_bodies.append(body)

func _on_body_entered(body):
	if not is_pulling and body.is_in_group("enemy"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
		queue_free()

func _on_timer_timeout():
	queue_free()

func set_pull_mode(active: bool):
	is_pulling = active
	if active:
		$Sprite2D.modulate = Color(1, 0.5, 1)  # Purple tint when pulling
	else:
		$Sprite2D.modulate = Color.WHITE
