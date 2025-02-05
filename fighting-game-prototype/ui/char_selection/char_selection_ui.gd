class_name CharSelectionUI
extends Control


@export_file("*.tscn") var map_path: String

var buttons: Array = []
var current_button
var current_index : int = 0

@onready var char_name: Label = $HBoxContainer2/CharName

@onready var grid_container: GridContainer = $HBoxContainer/GridContainer


func _ready() -> void:
	for button in grid_container.get_children():
		buttons.append(button)
	
	current_button = buttons[current_index]
	current_button.selected = true
	
	name_selection()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		move_selection(Vector2(-1, 0))  # Moves to the left
	elif event.is_action_pressed("move_right"):
		move_selection(Vector2(1, 0))  # Moves to the right
	elif event.is_action_pressed("move_jump"):
		move_selection(Vector2(0, -1))  # Moves up
	elif event.is_action_pressed("move_crouch"):
		move_selection(Vector2(0, 1))  # Moves down
	
	if event.is_action_pressed("enter") and current_index == 0:
		SceneLoader.load_scene(map_path)
	
	name_selection()


func move_selection(direction: Vector2):
	var new_index = current_index + direction.x + direction.y * 3
	new_index = clamp(new_index, 0, buttons.size() - 1)
	
	if new_index != current_index:
		current_button.selected = false  # Unselects current button
		current_button = buttons[new_index]  # Updates current button
		current_button.selected = true  # Selects current button
		current_index = new_index  # Updates index


func name_selection():
	match current_index:
		0:
			char_name.text = "Kiriya"
		_:
			char_name.text = "none"
