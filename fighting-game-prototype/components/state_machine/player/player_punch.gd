class_name PlayerStatePunch
extends BaseState


enum TimerType {
	CAN_ATTACK,
	END_ATTACK
}

const COMBO_TIME: float = 0.5
@export var idle_state: BaseState
@export var walk_state: BaseState
@export var jump_state: BaseState
@export var crouch_state: BaseState
var timer_type: TimerType = TimerType.CAN_ATTACK
var combo: Array = []
var can_combo: bool = false
var current_attack: BaseAttack = null
var attack_index: int = 0
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_timer_timeout)
	


func enter() -> void:
	super()
	combo = context.character_data.attacks.punches
	#animation_tree.animation_travel("Idle")
	attack_index = 0
	context.velocity.x = 0
	context.is_punching = true
	timer_type = TimerType.CAN_ATTACK
	await combo_manager(true)
	play_attack()
	if not context.animation_tree.animation_finished.is_connected(_animation_finished):
		context.animation_tree.animation_finished.connect(_animation_finished)

func input(_event: InputEvent) -> BaseState:
	# TODO: Start the combo
	return null


func physics_process(delta: float) -> BaseState:
	animation_tree.set_blend_position(Vector2.ZERO)
	context.velocity.y -= (gravity * delta)
	context.move_and_slide()
	
	#if context.is_punching == false:
	#	return idle_state
	if Input.is_action_just_pressed("action_punch") and can_combo:
		combo_manager()
	#if animation_tree.animation_finished:
	#	return idle_state
	#if !context.is_punching:
	#	return idle_state
	#if !context.is_on_floor():
	#	return fall_state
	return null


func combo_manager(just_initiated: bool = false) -> void:
	if just_initiated:
		current_attack = combo[0]
		print(combo[0].animation_name)
	else:
		attack_index += 1
		if attack_index > combo.size() - 1:
			attack_index = 0
		current_attack = combo[attack_index]
		timer.stop()


func play_attack() -> void:
	var animation_name: String = current_attack.animation_name
	print(animation_name)
	animation_tree.set_movement_transition(animation_name)
	timer.wait_time = COMBO_TIME
	timer.start()


func _timer_timeout() -> void:
	if timer_type == TimerType.CAN_ATTACK:
		timer_type = TimerType.END_ATTACK
		can_combo = true
		timer.wait_time = COMBO_TIME
		timer.start()
	else:
		can_combo = false
		context.state_manager.change_state(idle_state)


func _animation_finished(anim_name: StringName) -> void:
	if anim_name != current_attack.animation_name:
		play_attack()
