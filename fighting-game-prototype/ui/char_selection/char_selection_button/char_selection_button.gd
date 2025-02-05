@tool
class_name CharSelectionButton
extends TextureButton


@export var selected: bool = false: 
	set(value):
		selected = value
		
		if selected_container is PanelContainer:
			if selected:
				selected_container.show()
			else:
				selected_container.hide()
	get:
		return selected
	

@onready var selected_container: PanelContainer = $SelectedContainer


func _ready() -> void:
	selected = selected
