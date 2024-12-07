extends BaseState


@export var death_state: BaseState

var last_direction: float


func enter() -> void:
	super()
	last_direction = context.direction
	animation_tree.animation_travel("Walk")
	animation_tree.animation_blend_all(last_direction)


func physics_process(delta: float) -> BaseState:
	context.velocity.y += gravity * delta
	
	var direction = get_movement_direction()

	if direction != last_direction:
		last_direction = direction
		@warning_ignore("int_as_enum_without_cast")
		context.direction = int(last_direction)
		animation_tree.animation_blend_all(last_direction)
	
	var movement: float = direction * context.speed
	context.velocity.x = movement
	
	context.move_and_slide()
	
	return null
