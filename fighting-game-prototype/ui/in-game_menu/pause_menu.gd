extends Control

@onready var base_ring: BaseRing
@onready var buttons: VBoxContainer = %Buttons


func _ready() -> void:
	# Connects all the main_menu buttons button_got_pressed signals.
	for button: UIButton in buttons.get_children():
		print(button)
		button.button_got_pressed.connect(_menu_button_pressed)


func init(parent: BaseRing) -> void: 
	base_ring = parent


func _menu_button_pressed(button: UIButton) -> void:
	match button.button_type:
		
		button.ButtonType.RESUME:
			hide()
			Global.pause_game(false)
		
		button.ButtonType.QUIT_GAME:
			get_tree().quit()
		
		button.ButtonType.RESTART:
			Global.pause_game(false)
			get_tree().reload_current_scene()
		
		_:
			if button.scene_path_to_load != "":
				SceneLoader.load_scene(button.scene_path_to_load)
