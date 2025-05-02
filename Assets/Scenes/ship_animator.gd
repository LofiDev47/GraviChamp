extends Node2D

@onready var sprite = $SpriteCranberry
@onready var anim_player = $AnimationPlayer
@onready var sound = preload("res://Assets/Sounds/accident-crash-sound-effect-made-with-Voicemod.mp3")

func _ready():
	anim_player.animation_finished.connect(_on_animation_finished)
	anim_player.play("Intro Scene/Shakey")  # 👈 Play the correct animation name

func _on_animation_finished(anim_name: StringName):
	if anim_name == "Intro Scene/Shakey":  # 👈 Check exact match
		$AudioStreamPlayer.stream = sound
		$AudioStreamPlayer.play()
