class_name PlayerStateKick
extends BaseStateAttack


func _ready() -> void:
	attack_prefix = "Kick"
	super()


func enter() -> void:
	super()
	combo = context.character_data.attacks.kicks
	attack_index = 0
	can_combo = false
	context.velocity.x = 0
	context.is_kicking = true
	@warning_ignore("redundant_await")
	await combo_manager(true)
	play_attack()
