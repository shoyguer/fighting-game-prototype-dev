class_name MainMenu
extends Control


enum State {
	PRE_MENU,
	MAIN_MENU
}

enum Fade {
	IN, OUT
}

@export var current_state: State = State.PRE_MENU
@export var fade_time: float = 0.5

var current_container: VBoxContainer

@onready var pre_menu: VBoxContainer = %PreMenu
@onready var main_menu: VBoxContainer = %MainMenu
@onready var game_version_label: Label = %GameVersionLabel


func _ready() -> void:
	main_menu.modulate.a = 0
	current_container = pre_menu
	
	# Connects all the main_menu buttons button_got_pressed signals.
	for button: UIButton in main_menu.get_children():
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
	
	match new_state:
		State.MAIN_MENU:
			# Hides old VBoxContainer
			await _fade_container(current_container, Fade.OUT)
			
			# Little timer
			await get_tree().create_timer(0.25).timeout
			
			# Sets new VBoxContainer then shows it.
			current_container = main_menu
			await _fade_container(current_container, Fade.IN)


func _menu_button_pressed(button: UIButton) -> void:
	match button.button_type:
		
		button.ButtonType.QUIT_GAME:
			get_tree().quit()
		
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
