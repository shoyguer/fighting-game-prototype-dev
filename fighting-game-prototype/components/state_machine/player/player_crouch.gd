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


func input(event: InputEvent) -> BaseState:
	if event.is_action_released("move_crouch"):
		context.mesh.scale.y = context.mesh.scale.y * 2
		context.collision.scale.y = context.collision.scale.y * 2
		return idle_state
	return null


func physics_process(delta: float) -> BaseState:
	print("crouching")
	
	context.velocity.y -= gravity * delta
	
	context.move_and_slide()
	
	return null
