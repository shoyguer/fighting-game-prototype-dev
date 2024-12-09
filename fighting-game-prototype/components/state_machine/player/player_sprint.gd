extends BaseState


@export var idle_state: BaseState
@export var jump_state: BaseState
@export var walk_state: BaseState

var acceleration = 50


func enter() -> void:
	super()


func physics_process(delta: float) -> BaseState:
	if wants_jump() and context.is_on_floor():
		return jump_state
	
	context.velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var movement: float = get_movement_direction() * context.sprint_speed
	context.velocity.x = move_toward(context.velocity.x, movement, acceleration * delta)
	
	context.move_and_slide()
	
	if movement == 0:
		return idle_state
	
	#elif (context.velocity.x != 0) and (context.velocity.y == 0):
	#	animation_tree.animation_blend_all(movement)
	
	return null
