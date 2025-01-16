class_name PlayerStateCrouch
extends BaseState


@export var idle_state: BaseState
@export var walk_state: BaseState
@export var jump_state: BaseState
@export var sprint_state: BaseState
var acceleration = 50


func enter() -> void:
	print("entrou crouch")
	#context.mesh.scale.y = context.mesh.scale.y / 2
	#context.collision.scale.y = context.collision.scale.y / 2
	super()


func input(event: InputEvent) -> BaseState:
	if event.is_action_released("move_crouch"):
		#context.mesh.scale.y = context.mesh.scale.y * 2
		#context.collision.scale.y = context.collision.scale.y * 2
		return walk_state
	return null


func physics_process(delta: float) -> BaseState:
	var current_input: Vector2 = Input.get_vector("move_left", "move_right", "move_crouch", "move_jump")
	animation_tree.set_blend_position(current_input)
	
	context.velocity.y -= gravity * delta
	
	var movement: float = get_movement_direction() * context.move_speed
	context.velocity.x = move_toward(context.velocity.x, movement/2, acceleration * delta)
	
	context.move_and_slide()
	
	return null
