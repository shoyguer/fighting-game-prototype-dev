class_name MainMenu
extends Control


enum State {
	PRE_MENU,
	MAIN_MENU,
	MENU_GAME_MODE,
	SERVER_MODE
}

enum Fade {
	IN, OUT
}

@export var current_state: State = State.PRE_MENU
@export var fade_time: float = 0.5

var current_container: VBoxContainer

@onready var pre_menu: VBoxContainer = %PreMenu
@onready var main_menu: VBoxContainer = %MainMenu
@onready var menu_game_mode: VBoxContainer = %MenuGameMode
@onready var server_mode: VBoxContainer = %ServerMode
@onready var game_version_label: Label = %GameVersionLabel


func _ready() -> void:
	main_menu.modulate.a = 0
	main_menu.hide()
	menu_game_mode.modulate.a = 0
	menu_game_mode.hide()
	server_mode.modulate.a = 0
	server_mode.hide()
	current_container = pre_menu
	
	# Connects all the main_menu buttons button_got_pressed signals.
	for button: UIButton in main_menu.get_children():
		button.button_got_pressed.connect(_menu_button_pressed)
	for button: UIButton in menu_game_mode.get_children():
		button.button_got_pressed.connect(_menu_button_pressed)
	for button in server_mode.get_children():
		if button is UIButton:
			button.button_got_pressed.connect(_menu_button_pressed)
		
	#region Set Game Version
	var game_version_label_text: String = "ver.: "
	
	# Sets game version
	for key in Global.game_version.keys():
		if (key != "major") and (key != "label"):
			game_version_label_text += "."
		if key == "label":
			game_version_label_text += "-"
		game_version_label_text += Global.game_version[key]
	
	game_version_label.text = game_version_label_text
	#endregion


func _input(event: InputEvent) -> void:
	if (event is not InputEventMouse) and (event is not InputEventMouseMotion) and (
		current_state == State.PRE_MENU):
		_menu_state_manager(State.MAIN_MENU)


func _menu_state_manager(new_state: State) -> void:
	current_state = new_state
	print(current_state)
	
	match new_state:
		State.MAIN_MENU:
			# Hides old VBoxContainer
			await _fade_container(current_container, Fade.OUT)
			
			# Little timer
			await get_tree().create_timer(0.25).timeout
			
			# Sets new VBoxContainer then shows it.
			current_container = main_menu
			await _fade_container(current_container, Fade.IN)
		State.MENU_GAME_MODE:
			await _fade_container(current_container, Fade.OUT)
			
			# Little timer
			await get_tree().create_timer(0.25).timeout
			
			# Sets new VBoxContainer then shows it.
			current_container = menu_game_mode
			await _fade_container(current_container, Fade.IN)
		State.SERVER_MODE:
			await _fade_container(current_container, Fade.OUT)
			
			# Little timer
			await get_tree().create_timer(0.25).timeout
			
			# Sets new VBoxContainer then shows it.
			current_container = server_mode
			await _fade_container(current_container, Fade.IN)


func _menu_button_pressed(button: UIButton) -> void:
	match button.button_type:
		
		button.ButtonType.QUIT_GAME:
			get_tree().quit()
		
		button.ButtonType.NEW_GAME:
			_menu_state_manager(State.MENU_GAME_MODE)
		
		button.ButtonType.MULTIPLAYER:
			_menu_state_manager(State.SERVER_MODE)
		
		_:
			if button.scene_path_to_load != "":
				SceneLoader.load_scene(button.scene_path_to_load)


func _fade_container(container: VBoxContainer, type: Fade) -> void:
	var tween = get_tree().create_tween()
	
	match type:
		Fade.IN:
			container.show()
			tween.tween_property(container, "modulate:a", 1, fade_time)
			await tween.finished
			return
		
		Fade.OUT:
			tween.tween_property(container, "modulate:a", 0, fade_time)
			tween.tween_callback(func():
				container.hide()
				)
			await tween.finished
			return
