extends BaseState


@export var idle_state: BaseState
@export var jump_state: BaseState
@export var sprint_state: BaseState

var acceleration = 50

var sprint_max_time: float = 5
var sprint_cur_time: float = 0.0
var sprint_wait_time: bool = false

var sprint_key: int = 0

func enter() -> void:
	print("entrou walk")
	super()
	#animation_tree.animation_travel("Walk")

func input(_event: InputEvent) -> BaseState:
	sprint_key = move_component.get_movement_released()
	if sprint_key != 0:
		sprint_wait_time = true
	if move_component.get_movement_direction() != 0 and sprint_wait_time == true:
		sprint_wait_time = false
	#if Input.is_action_pressed("move_sprint"):
	#	return sprint_state
	return null

func physics_process(delta: float) -> BaseState:
	print("walking")
	
	if sprint_cur_time >= sprint_max_time:
		sprint_wait_time = false
	if sprint_wait_time == true:
		sprint_cur_time += delta
		if sprint_key == get_movement_direction():
			return sprint_state
	if wants_jump() and context.is_on_floor():
		return jump_state
	
	context.velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var movement: float = get_movement_direction() * context.move_speed
	context.velocity.x = move_toward(context.velocity.x, movement, acceleration * delta)
	
	context.move_and_slide()
	
	if movement == 0 and sprint_wait_time == false:
		return idle_state
	
	#elif (context.velocity.x != 0) and (context.velocity.y == 0):
	#	animation_tree.animation_blend_all(movement)
	
	return null
