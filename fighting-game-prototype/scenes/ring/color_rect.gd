extends ColorRect

const CHARACTER_RESOURCE = preload("res://components/CharacterResource.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	custom_minimum_size.x = CHARACTER_RESOURCE.max_health
