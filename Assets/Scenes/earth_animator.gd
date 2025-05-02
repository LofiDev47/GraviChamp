extends Node2D

@onready var sprite = $SpritePooDee
@onready var anim_player = $AnimationPlayer



func _ready():
	anim_player.animation_finished.connect(_on_animation_finished)
	anim_player.play("Planet/Shakey")  # 👈 Play the correct animation name

func _on_animation_finished(anim_name: StringName):
	if anim_name == "Planet/Shakey":  # 👈 Check exact match
		sprite.texture = load("res://Assets/Sprites/ShatteredEarth.png")
