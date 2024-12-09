class_name StateManager
extends Node


@export var starting_state: BaseState

var current_state: BaseState
var states: Dictionary = {}


func init(context: BaseCharacter) -> void:
	starting_state = context.starting_state
	
	for child: BaseState in get_children():
		child.init(context)
	
	change_state(starting_state)


func change_state(new_state: BaseState) -> void:
	print(new_state.name)
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func physics_process(delta: float) -> void:
	var new_state = current_state.physics_process(delta)
	if new_state:
		change_state(new_state)


func input(event: InputEvent) -> void:
	var new_state = current_state.input(event)
	if new_state:
		change_state(new_state)


func process(delta: float) -> void:
	var new_state = current_state.process(delta)
	if new_state:
		change_state(new_state)
