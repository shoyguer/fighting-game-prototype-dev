class_name PlayerStateHurt
extends BaseState


func enter() -> void:
	super()
	context.is_hit = true
	context.velocity.x = 0
	animation_tree.set_movement_transition("Hit")
	AudioManager.play_random_sfx(context.character_data.sfx_hurt_pool, -12)
	
	if not context.animation_tree.animation_finished.is_connected(_animation_finished):
		context.animation_tree.animation_finished.connect(_animation_finished)


func physics_process(delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_sprint_blend(Vector2.ZERO)
	
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	return null


func _animation_finished(anim_name: StringName) -> void:
	if anim_name == "Hit":
		context.state_manager.change_state(context.idle_state)
