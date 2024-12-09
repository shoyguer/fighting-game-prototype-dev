extends BaseState


@export var idle_state: BaseState
@export var jump_state: BaseState
@export var sprint_state: BaseState


func enter() -> void:
	print("entrou crouch")
	context.mesh.scale.y = context.mesh.scale.y / 2
	context.collision.scale.y = context.collision.scale.y / 2
	super()
	#animation_tree.animation_travel("Walk")

func input(_event: InputEvent) -> BaseState:
	if Input.is_action_just_released("move_crouch"):
		context.mesh.scale.y = context.mesh.scale.y * 2
		context.collision.scale.y = context.collision.scale.y * 2
		return idle_state
	return null

func physics_process(delta: float) -> BaseState:
	print("crouching")
	
	context.velocity.y -= gravity * delta
	
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var movement: float = get_movement_direction() * context.move_speed
	#context.velocity.x = context.crouch_speed
	
	context.move_and_slide()
	
	#if movement == 0:
	#	return idle_state
	
	#elif (context.velocity.x != 0) and (context.velocity.y == 0):
	#	animation_tree.animation_blend_all(movement)
	
	return null
