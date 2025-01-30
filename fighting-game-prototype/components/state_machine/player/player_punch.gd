class_name PlayerStatePunch
extends BaseStateAttack


func enter() -> void:
	super()
	combo = context.character_data.attacks.punches
	attack_index = 0
	can_combo = false
	context.velocity.x = 0
	context.is_punching = true
	@warning_ignore("redundant_await")
	await combo_manager(true)
	play_attack()
