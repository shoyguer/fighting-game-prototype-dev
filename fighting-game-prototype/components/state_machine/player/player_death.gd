class_name PlayerStateDeath
extends BaseState


@export var idle_state: BaseState
@export var walk_state: BaseState
@export var jump_state: BaseState
@export var crouch_state: BaseState
@export var punch_state: BaseState
@export var kick_state: BaseState


func enter() -> void:
	super()
	context.is_dead = true
	context.velocity.x = 0
	animation_tree.set_movement_transition("Death")


func physics_process(delta: float) -> BaseState:
	animation_tree.set_blend_position(Vector2.ZERO)
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	return null
