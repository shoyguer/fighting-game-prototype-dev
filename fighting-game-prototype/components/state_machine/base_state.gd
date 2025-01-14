class_name BaseState
extends Node


var animation_tree: AnimationStateMachine
var move_component: MoveComponent
var context: BaseCharacter
var gravity: int = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready():
	pass


func init(_context):
	context = _context
	move_component = context.move_component
	animation_tree = context.animation_tree
	
	# Gets all needed states from the Context
	var this_script: GDScript = get_script()
	for property in this_script.get_script_property_list():
		if property.class_name == &"BaseState":
			var state_property: StringName = property.name
			set(state_property, context.get(property.name))


func enter() -> void:
	pass


func exit() -> void:
	pass


func input(_event: InputEvent) -> BaseState:
	return null


func process(_delta: float) -> BaseState:
	return null


func physics_process(_delta: float) -> BaseState:
	return null


func get_movement_direction() -> float:
	return move_component.get_movement_direction()


func wants_jump() -> bool:
	return move_component.wants_jump()
