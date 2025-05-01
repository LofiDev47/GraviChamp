extends Node2D

@export var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _process(delta):
	# flips the character sprite
	if player_controller.direction == 1:
		sprite.flip_h = false
	elif player_controller.direction == -1:
		sprite.flip_h = true
	# plays the movement animation
	if abs(player_controller.velocity.x) > 0.0:
		animation_player.play("move")
		$Sprite2D.texture = load("res://Assets/Sprites/The Male adventurer - Free/Walk/walk_right_down.png")
	else:
		animation_player.play("idle")
		$Sprite2D.texture = load("res://Assets/Sprites/The Male adventurer - Free/Idle/idle_right_down.png")
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
		$Sprite2D.texture = load("res://Assets/Sprites/The Male adventurer - Free/Jump - NEW/Normal/Jump_Right_Down.png" )
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
		$Sprite2D.texture = load("res://Assets/Sprites/The Male adventurer - Free/Jump - NEW/Normal/Jump_Right_Down.png" )
