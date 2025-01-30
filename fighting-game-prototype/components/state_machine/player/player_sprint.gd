class_name PlayerStateSprint
extends BaseState


var acceleration = 50


func enter() -> void:
	super()
	animation_tree.set_movement_transition("Sprint")


func physics_process(delta: float) -> BaseState:
	if context.is_player:
		var current_input: Vector2 = Input.get_vector("move_left", "move_right", "move_crouch", "move_jump")
		animation_tree.set_sprint_blend(current_input, 2.0)
		
		if wants_jump() and context.is_on_floor():
			return context.jump_state
		
		context.velocity.y -= gravity * delta
		
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var movement: float = get_movement_direction() * context.sprint_speed
		context.velocity.x = move_toward(context.velocity.x, movement, acceleration * delta)
		
		context.move_and_slide()
		
		if movement == 0:
			return context.idle_state
	
	return null
