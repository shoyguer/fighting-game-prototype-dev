extends Node3D

@onready var base_character: BaseCharacter = $BaseCharacter
@onready var ui: Control = $UI


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	base_character.in_battle = false

func _input(event: InputEvent) -> void:
	if ui.current_index == 0:
		base_character.show()
		if event.is_action_pressed("enter"):
			pass
	else:
		base_character.hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
