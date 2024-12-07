class_name MoveComponent
extends Node


@export var parent: BaseCharacter

var direction: float


func init(new_parent: BaseCharacter) -> void:
	parent = new_parent
	direction = parent.direction


func wants_jump() -> bool:
	push_error("The wants_jump was called without being overriden.")
	return false


func get_movement_direction() -> float:
	push_error("The get_movement_direction was called without being overriden.")
	return 0.0
