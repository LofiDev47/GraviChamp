extends CharacterBody2D
class_name SimpleEnemy

# Configuration
@export var health := 2
@export var move_speed := 60.0
@export var damage := 1
@export var particle_count := 15  # Reduced for performance

func _ready():
	add_to_group("enemy")  # Required for laser system
	_setup_particles()  # Initialize particles safely

func _setup_particles():
	# Configure CPU particles for low-end devices
	$DeathParticles.amount = particle_count
	$DeathParticles.lifetime = 0.8
	
	# Create and configure the proper 2D particle material
	var material = ParticleProcessMaterial.new()
	material.gravity = Vector3(0, 98, 0)
	material.spread = 45
	material.initial_velocity = 50
	
	$DeathParticles.process_material = material

func take_damage(amount):
	health -= amount
	# Visual feedback (no particles needed)
	$Sprite2D.modulate = Color(1, 0.3, 0.3)
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.modulate = Color.WHITE
	
	if health <= 0:
		die()

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	$Sprite2D.hide()
	$DeathParticles.emitting = true
	await get_tree().create_timer($DeathParticles.lifetime).timeout
	queue_free()
