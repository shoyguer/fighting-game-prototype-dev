class_name PlayerStateIdle
extends BaseState


@export var walk_state: BaseState
@export var jump_state: BaseState
@export var crouch_state: BaseState
@export var punch_state: BaseState
@export var kick_state: BaseState
@export var hit_state: BaseState
@export var death_state: BaseState


func enter() -> void:
	super()
	context.velocity.x = 0
	animation_tree.set_movement_transition("Walk")


func input(_event: InputEvent) -> BaseState:
	if wants_jump() and context.is_on_floor():
		return jump_state
	if get_movement_direction() != 0.0:
		return walk_state
	if Input.is_action_pressed("move_crouch"):
		return crouch_state
	if Input.is_action_just_pressed("action_punch"):
		return punch_state
	if Input.is_action_just_pressed("action_kick"):
		return kick_state
	if Input.is_action_just_pressed("less_health"):
		return hit_state
	return null


func physics_process(delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_walk_blend(Vector2.ZERO)
	
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	if context.is_dead:
		return death_state
	return null
