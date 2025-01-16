@tool
class_name AnimationStateMachine
extends AnimationTree


@export var action_animation: String
@export var locomotion: String
var animations: Array[String] = []
var blend_weight: float = 0.2


func init(context: BaseCharacter) -> void:
	animations = context.animations


func set_movement_transition(action: String) -> void:
	set(action_animation, action)


func set_blend_position(move: Vector2) -> void:
	var move_original: Vector2 = get(locomotion)
	move_original.x = lerp(move_original.x, move.x, blend_weight)
	move_original.y = lerp(move_original.y, move.y, blend_weight)
	set(locomotion, move_original)
