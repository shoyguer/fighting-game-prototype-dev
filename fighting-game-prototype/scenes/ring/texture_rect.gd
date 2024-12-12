extends TextureRect

@export var base_character: BaseCharacter


func _ready() -> void:
	texture = base_character.character_data.portrait_image

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
