extends Control

@export var scroll_duration: float = 20.0
@export var next_scene: String = "res://MainMenu.tscn"

@onready var scrollbar: VScrollBar = $VScrollBar
@onready var credits_text: RichTextLabel = $VScrollBar/RichTextLabel
@onready var music_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	# Verify nodes exist
	if not scrollbar:
		push_error("VScrollBar node not found!")
		return
	if not credits_text:
		push_error("RichTextLabel not found!")
		return
	
	# Play music if available
	if music_player and music_player.stream:
		music_player.play()
	
	# Wait for layout to calculate
	await get_tree().process_frame
	
	# Setup scrollbar
	_setup_scrolling()
	
	# Start animation if needed
	if scrollbar.max_value > 0:
		animate_scrolling()
	else:
		await get_tree().create_timer(2.0).timeout
		end_credits()

func _setup_scrolling():
	# Calculate scrollable area
	var text_height = credits_text.size.y
	var visible_height = credits_text.get_parent().size.y
	
	scrollbar.min_value = 0
	scrollbar.max_value = max(0, text_height - visible_height)
	scrollbar.value = 0
	
	# Connect scrollbar movement to text position
	scrollbar.value_changed.connect(_update_text_position)

func _update_text_position(value: float):
	credits_text.position.y = -value

func animate_scrolling():
	var tween = create_tween()
	tween.tween_property(
		scrollbar,
		"value",
		scrollbar.max_value,
		scroll_duration
	).set_trans(Tween.TRANS_LINEAR)
	tween.finished.connect(end_credits)

func end_credits():
	if music_player:
		music_player.stop()
	get_tree().change_scene_to_file(next_scene)
