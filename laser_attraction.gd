extends Area2D
class_name LaserAttraction

@export var speed := 600.0
@export var pull_force := 150.0
var is_pulling := false

func _ready():
	# Auto-delete after timer ends
	$Timer.timeout.connect(queue_free)
	
	# Connect hit detection
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	if is_pulling:
		_pull_objects(delta)
	else:
		# Move forward
		position += transform.x * speed * delta

func _pull_objects(delta):
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy"):
			var direction = (global_position - body.global_position).normalized()
			body.velocity += direction * pull_force * delta

func _on_body_entered(body):
	if body.is_in_group("enemy") and !is_pulling:
		body.take_damage(1)
		queue_free()

func set_pull_mode(active: bool):
	is_pulling = active
	$Sprite2D.modulate = Color.PURPLE if active else Color.WHITE
