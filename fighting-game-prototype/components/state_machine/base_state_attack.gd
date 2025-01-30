class_name BaseStateAttack
extends BaseState


var combo: Array = []
var can_combo: bool = false
var current_attack: BaseAttack = null
var attack_index: int = 0
var attack_prefix: String

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_timer_timeout)


func enter() -> void:
	if not context.animation_tree.animation_finished.is_connected(_animation_finished):
		context.animation_tree.animation_finished.connect(_animation_finished)


func input(event: InputEvent) -> BaseState:
	if event.is_action_pressed("action_punch") and can_combo:
		combo_manager()
	return null


func physics_process(delta: float) -> BaseState:
	animation_tree.set_walk_blend(Vector2.ZERO)
	animation_tree.set_sprint_blend(Vector2.ZERO)
	
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	return null


func combo_manager(just_initiated: bool = false) -> void:
	can_combo = false
	if just_initiated:
		current_attack = combo[0]
	else:
		attack_index += 1
		if attack_index > combo.size() - 1:
			attack_index = 0
		current_attack = combo[attack_index]
		timer.stop()


func play_attack() -> void:
	var animation_name: String = current_attack.animation_name
	animation_tree.set_movement_transition(animation_name)
	timer.wait_time = current_attack.animation_time
	timer.start()


func _timer_timeout() -> void:
	context.set_hit_box(current_attack)
	context.disable_hit_box(false)
	can_combo = true
	await get_tree().create_timer(0.33).timeout
	context.disable_hit_box(true)


func _animation_finished(anim_name: StringName) -> void:
	if anim_name.begins_with(attack_prefix):
		
		if anim_name != current_attack.animation_name:
			play_attack()
		else:
			context.state_manager.change_state(context.idle_state)
