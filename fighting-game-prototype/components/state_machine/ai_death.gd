extends BaseState


@export var walk_state: BaseState


func enter() -> void:
	super()
	animation_tree.animation_travel("Death")
	await get_tree().create_timer(0.36).timeout
	AudioManager.play_audio("dying_enemy", 0)
	await animation_tree.animation_finished
	context.queue_free()
