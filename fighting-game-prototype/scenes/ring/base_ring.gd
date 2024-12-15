class_name BaseRing
extends Node3D

@onready var pause_menu: Control = $PauseMenu
var paused: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


func pauseMenu() -> void:
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused != paused
