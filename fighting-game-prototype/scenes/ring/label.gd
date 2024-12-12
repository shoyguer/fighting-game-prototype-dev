extends Label

@export var base_character: BaseCharacter
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = base_character.character_data.character_name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
