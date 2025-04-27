extends Node2D

var player_controller : PlayerController
@export var animation_player : AnimationPlayer
@export var sprite : Sprite2D

func _ready():
	player_controller = get_parent() as PlayerController

func _process(_delta):
	if player_controller == null:
		return # early out if something's wrong
	
	# Flip sprite based on direction
	sprite.flip_h = player_controller.direction == -1

	# Play animations based on movement
	if player_controller.velocity.y < 0.0:
		animation_player.play("jump")
	elif player_controller.velocity.y > 0.0:
		animation_player.play("fall")
	else:
		if abs(player_controller.velocity.x) > 0.0:
			animation_player.play("move")
		else:
			animation_player.play("idle")
