extends CanvasLayer

@export var messages := [
	"Earth: YOU FOUND IT!",
	"Earth: Alright all you eed to do now is insert the batterys",
	"Player: I think I can do that",
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
		get_tree().change_scene_to_file("res://Assets/Scenes/Areas/Credits.tscn")
