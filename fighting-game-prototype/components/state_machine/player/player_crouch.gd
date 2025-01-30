class_name PlayerStateCrouch
extends BaseState


var acceleration = 50


func input(event: InputEvent) -> BaseState:
	if event.is_action_released("move_crouch"):
		return context.walk_state
	return null


func physics_process(delta: float) -> BaseState:
	if context.is_player:
		var current_input: Vector2 = Input.get_vector("move_left", "move_right", "move_crouch", "move_jump")
		animation_tree.set_walk_blend(current_input)
		
		context.velocity.y -= gravity * delta
		
		var movement: float = get_movement_direction() * context.move_speed
		context.velocity.x = move_toward(context.velocity.x, movement/2, acceleration * delta)
		
		context.move_and_slide()
	
	return null
