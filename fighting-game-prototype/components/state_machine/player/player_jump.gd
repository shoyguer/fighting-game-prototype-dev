class_name PlayerStateJump
extends BaseState


@export var idle_state: BaseState
@export var walk_state: BaseState
@export var hit_state: BaseState


func enter() -> void:
	print("entrou pulo")
	super()
	#animation_tree.animation_travel("Jump")
	context.velocity.y = context.jump_velocity
	#AudioManager.play_audio("jump", 0)
	animation_tree.set_movement_transition("jump_input")


func input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("less_health"):
		return hit_state
	return null


func physics_process(delta: float) -> BaseState:
	context.velocity.y -= gravity * delta
	
	#if context.velocity.y > 0:
	#	return fall_state
	
	var movement = get_movement_direction() * context.move_speed

	context.velocity.x = movement
	context.move_and_slide()
	
	#if context.velocity.x != 0:
	#	animation_tree.animation_blend_all(movement)
	
	if context.is_on_floor():
		if movement != 0:
			return walk_state
		return idle_state
	
	return null
