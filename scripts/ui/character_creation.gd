extends Control

# Basic character creation to make the game playable

@onready var name_input = $VBoxContainer/NameInput
@onready var pronoun_option = $VBoxContainer/PronounOption
@onready var confirm_button = $VBoxContainer/ConfirmButton

func _ready():
	if confirm_button:
		confirm_button.pressed.connect(_on_confirm_pressed)
	else:
		# Fallback if UI is missing
		print("Character creation UI incomplete - skipping to game")
		_skip_to_game()

func _on_confirm_pressed():
	# Save character data
	if name_input:
		GameState.player_name = name_input.text
	
	if pronoun_option and pronoun_option.selected >= 0:
		var pronouns = ["she/her", "he/him", "they/them", "custom"]
		GameState.player_pronouns = pronouns[pronoun_option.selected]
	
	_skip_to_game()

func _skip_to_game():
	# Go straight to daily card then apartment
	# (Train scene doesn't exist)
	print("Starting game...")
	get_tree().change_scene_to_file("res://scenes/ui/daily_card_scene.tscn")

# Allow Enter key to confirm
func _input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:
			_on_confirm_pressed()