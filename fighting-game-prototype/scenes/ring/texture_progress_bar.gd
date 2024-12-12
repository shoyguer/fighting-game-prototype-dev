extends TextureProgressBar

@export var character_resource: CharacterResource

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	value = 1000
