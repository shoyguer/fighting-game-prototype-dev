extends ColorRect

@export var base_character: BaseCharacter

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	custom_minimum_size.x = base_character.character_data.current_health
