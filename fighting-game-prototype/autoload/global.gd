extends Node


var game_version: Dictionary = {
	"major": "0",
	"minor": "00",
	"build": "06",
	"label": "pre-alpha"}


func pause_game(mode: bool) -> void:
	# If the game is already paused, it will just return, without changing the state, to prevent redundant changes.
	if get_tree().paused == mode:
		return
	get_tree().paused = mode


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game(true)
