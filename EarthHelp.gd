extends CanvasLayer
var resource = load("res://Assets/Dialogue/Earth Help.dialogue")
# then
var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
