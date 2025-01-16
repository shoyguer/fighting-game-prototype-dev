class_name PlayerStateKick
extends BaseState


@export var idle_state: BaseState
@export var walk_state: BaseState
@export var jump_state: BaseState
@export var crouch_state: BaseState


func enter() -> void:
	super()
	context.is_kicking = true
	#animation_tree.animation_travel("Idle")
	context.velocity.x = 0
	animation_tree.set_movement_transition("kick_input")


func physics_process(delta: float) -> BaseState:
	animation_tree.set_blend_position(Vector2.ZERO)
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	if context.is_kicking == false:
		return idle_state
	#if !context.is_on_floor():
	#	return fall_state
	return null
