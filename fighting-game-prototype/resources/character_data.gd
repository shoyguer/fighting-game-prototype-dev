class_name CharacterData
extends Resource

@export var max_health: int = 1000
@export var portrait_image: Texture
@export var character_name: String
@export var attacks: Dictionary = {"punches": [], "kicks": []}

@export_group("SFX")
@export_file("*.wav") var sfx_hurt_pool: Array[String] = []
@export_file("*.wav") var sfX_death: String = ""

var current_health: int = 1000:
	set(value):
		current_health = clampi(value, 0, max_health)
	get:
		return current_health
