class_name HUDControl
extends Control

@export var character_0: BaseCharacter

@onready var portrait_0: TextureRect = %Portrait0
@onready var health_bar_0: TextureProgressBar = %HealthBar0
@onready var name_0: Label = %Name0


@export var character_1: BaseCharacter

@onready var portrait_1: TextureRect = %Portrait1
@onready var health_bar_1: TextureProgressBar = %HealthBar1
@onready var name_1: Label = %Name1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar_0.max_value = character_0.character_data.max_health
	health_bar_0.value = character_0.character_data.current_health
	name_0.text = character_0.character_data.character_name
	character_0.health_bar = health_bar_0
	
	health_bar_1.max_value = character_1.character_data.max_health
	health_bar_1.value = character_1.character_data.current_health
	name_1.text = character_1.character_data.character_name
	character_1.health_bar = health_bar_1


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("more_health"):
		character_0.character_data.current_health += 100
		_animate_health(character_0)
	if event.is_action_pressed("less_health"):
		character_0.character_data.current_health -= 100
		_animate_health(character_0)
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _animate_health(character: BaseCharacter) -> void:
	var current_health: float = character.character_data.current_health
	
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(character.health_bar, "value", current_health, 0.25)
