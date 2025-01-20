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
	context.collision.set_deferred("disabled", true)


func physics_process(_delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_sprint_blend(Vector2.ZERO)
	
	return null
