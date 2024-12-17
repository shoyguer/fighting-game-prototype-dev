class_name BaseRing
extends Node3D

@onready var pause_menu_HUD: Control = $PauseMenu
var paused: bool = false


func _ready() -> void:
	pause_menu_HUD.init(self)


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_menu()


func pause_menu() -> void:
	if paused:
		pause_menu_HUD.hide()
		Global.pause_game(false)
		print(paused)
	else:
		pause_menu_HUD.show()
		Global.pause_game(true)
		print(paused)
	paused != paused
