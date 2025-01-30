class_name PlayerStateIdle
extends BaseState


func enter() -> void:
	super()
	context.velocity.x = 0
	animation_tree.set_movement_transition("Walk")


func input(event: InputEvent) -> BaseState:
	if wants_jump() and context.is_on_floor():
		return context.jump_state
	if get_movement_direction() != 0.0:
		return context.walk_state
	
	if event.is_action_pressed("move_crouch"):
		return context.crouch_state
	if event.is_action_pressed("action_punch"):
		return context.punch_state
	if event.is_action_pressed("action_kick"):
		return context.kick_state
	if event.is_action_pressed("less_health"):
		return context.hurt_state
	return null


func physics_process(delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_walk_blend(Vector2.ZERO)
	
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	if context.is_dead:
		return context.death_state
	
	return null
