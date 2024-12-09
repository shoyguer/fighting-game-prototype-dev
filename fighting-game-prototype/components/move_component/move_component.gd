class_name MoveComponent
extends Node


@export var parent: BaseCharacter

var direction: float


func init(new_parent: BaseCharacter) -> void:
	parent = new_parent
	direction = parent.direction


func wants_jump() -> bool:
	#push_error("The wants_jump was called without being overriden.")
	return Input.is_action_just_pressed('move_jump')


func get_movement_direction() -> float:
	#direction =  Input.get_axis("move_left", "move_right")
	#push_error("The get_movement_direction was called without being overriden.")
	return Input.get_axis("move_left", "move_right")


func get_movement_released() -> float:
	var direction: float
	if Input.is_action_just_released("move_left"):
		direction = -1
	if Input.is_action_just_released("move_right"):
		direction = 1
	return direction


func get_movement_pressed() -> float:
	var direction: float
	if Input.is_action_just_pressed("move_left"):
		direction = -1
	if Input.is_action_just_pressed("move_right"):
		direction = 1
	return direction
