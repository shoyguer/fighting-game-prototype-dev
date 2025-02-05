class_name MapSelection
extends Control


@export_file("*.tscn") var game_path: String

var buttons: Array = []
var current_button
var current_index : int = 0

@onready var h_box_container: HBoxContainer = $VBoxContainer/HBoxContainer


func _ready() -> void:
	for button in h_box_container.get_children():
		buttons.append(button)
	
	current_button = buttons[current_index]
	current_button.selected = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		move_selection(-1)  # Mover para a esquerda
	elif event.is_action_pressed("move_right"):
		move_selection(1)  # Mover para a direita
	
	if event.is_action_pressed("enter"):
		SceneLoader.load_scene(game_path)


func move_selection(direction: int):
	var new_index = current_index + direction
	new_index = clamp(new_index, 0, buttons.size() - 1)
	
	if new_index != current_index:
		current_button.selected = false  # Desmarcar o botão atual
		current_button = buttons[new_index]  # Atualizar o botão selecionado
		current_button.selected = true  # Marcar o novo botão
		current_index = new_index  # Atualizar o índice atual
