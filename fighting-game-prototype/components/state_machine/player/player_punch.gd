extends BaseState

@export var idle_state: BaseState
@export var walk_state: BaseState
@export var jump_state: BaseState
@export var crouch_state: BaseState


func enter() -> void:
	super()
	#animation_tree.animation_travel("Idle")
	context.velocity.x = 0
	context.is_punching = true
	animation_tree.set_movement_transition("punch_input")


func input(_event: InputEvent) -> BaseState:
	#if wants_jump() and context.is_on_floor():
	#	return jump_state
	#if get_movement_direction() != 0.0:
	#	return walk_state
	#if Input.is_action_pressed("move_crouch"):
	#	return crouch_state
	return null


func physics_process(delta: float) -> BaseState:
	animation_tree.set_blend_position(Vector2.ZERO)
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	if context.is_punching == false:
		return idle_state
	#if animation_tree.animation_finished:
	#	return idle_state
	#if !context.is_punching:
	#	return idle_state
	#if !context.is_on_floor():
	#	return fall_state
	return null
