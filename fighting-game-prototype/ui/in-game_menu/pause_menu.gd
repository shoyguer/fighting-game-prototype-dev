extends Control

@onready var base_ring: BaseRing = $".."


func _on_resume_pressed() -> void:
	base_ring.pause_menu.hide()
	Engine.time_scale = 1


func _on_quit_pressed() -> void:
	get_tree().quit()
