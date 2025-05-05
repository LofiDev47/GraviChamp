extends CanvasLayer

@export var messages := [
	"Earth: HEY you I can sense you!",
	"Earth: PLEASE HELP ME!",
	"Earth: They have crashed into me destroying my gravitational field",
	"Earth: I need you to refuel The Kepler Engine to restore my gravity",
	"Player: Uhh sure",
	"Earth: Just collect all the batterys in each area then go through each portal",
	"Earth: I'll guide you to the engine",
]
var current_message := 0

func _ready():
	show_message(0)

func show_message(index):
	$ColorRect/VBoxContainer/Label.text = messages[index]

func _on_continue_pressed():
	current_message += 1
	if current_message < messages.size():  # Changed from len() to size()
		show_message(current_message)
	else:
		get_tree().change_scene_to_file("res://Assets/Scenes/Areas/area_1.tscn")
