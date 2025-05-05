extends Node2D

@onready var sprite = $SpritePooDee
@onready var sound = preload("res://Assets/Sounds/yippee-tbh.mp3")

func _ready() -> void:
	print("Node ready!")
	await get_tree().create_timer(3.0).timeout
	print("3 seconds passed")
	sprite.texture = preload("res://Assets/Sprites/Earth.png")
	$AudioStreamPlayer.stream = sound
	$AudioStreamPlayer.play()
