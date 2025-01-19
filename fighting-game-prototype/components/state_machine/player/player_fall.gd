extends BaseState

@export var idle_state: BaseState
@export var walk_state: BaseState


func enter() -> void:
	super()
	animation_tree.animation_travel("Fall")

func physics_process(delta: float) -> BaseState:
	context.velocity.y += gravity * delta

	var movement = get_movement_direction() * context.speed
	
	context.velocity.x = movement
	context.move_and_slide()
	
	if context.velocity.x != 0:
		animation_tree.animation_blend_all(movement)
	
	if context.is_on_floor():
		if movement != 0:
			return walk_state
		
		return idle_state
	
	return null
