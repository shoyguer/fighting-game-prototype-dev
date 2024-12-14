@tool
class_name UIButton
extends Button


signal button_got_pressed(button: UIButton)

enum ButtonType {
	RESUME,
	NEW_GAME,
	LOAD_GAME,
	SETTINGS,
	RESTART,
	QUIT_MENU,
	QUIT_GAME
}

@export var button_type: ButtonType
## You can just drag and drop the [PackedScene] here, and it will automatically set
## the [member scene_path_to_load]. By doing so, this variable will still be empty. [br]
## This variable NEEDS to stay empty, otherwise, it will load the whole scene for
## every button, and take memory (and the [SceneLoader] will have no point in existing).
@export var scene_to_load: PackedScene:
	set(value):
		if (scene_path_to_load is String) and (value != null):
			scene_path_to_load = value.resource_path
	get:
		return scene_to_load
@export var scene_path_to_load: String


func _ready() -> void:
	scene_to_load = scene_to_load


func _button_pressed() -> void:
	button_got_pressed.emit(self)
