class_name PlayerStateDeath
extends BaseState


func enter() -> void:
	super()
	context.is_dead = true
	context.velocity.x = 0
	animation_tree.set_movement_transition("Death")
	context.collision.set_deferred("disabled", true)
	AudioManager.play_sfx(context.character_data.sfX_death)


func physics_process(_delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_sprint_blend(Vector2.ZERO)
	
	return null
