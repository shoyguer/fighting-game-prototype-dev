class_name PlayerStateKick
extends BaseState


@export var idle_state: BaseState
@export var walk_state: BaseState
@export var jump_state: BaseState
@export var crouch_state: BaseState


func enter() -> void:
	super()
	context.is_kicking = true
	context.velocity.x = 0
	animation_tree.set_movement_transition("Kick")


func physics_process(delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_sprint_blend(Vector2.ZERO)
	
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	if context.is_kicking == false:
		return idle_state
	return null
