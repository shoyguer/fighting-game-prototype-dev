class_name PlayerStateJump
extends BaseState


func enter() -> void:
	super()
	context.velocity.y = context.jump_velocity
	animation_tree.set_movement_transition("Jump")


func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("less_health"):
		return context.hurt_state
	return null


func physics_process(delta: float) -> BaseState:
	context.velocity.y -= gravity * delta
	
	var movement = get_movement_direction() * context.move_speed

	context.velocity.x = movement
	context.move_and_slide()
	
	if context.is_on_floor():
		if movement != 0:
			return context.walk_state
		return context.idle_state
	
	return null
