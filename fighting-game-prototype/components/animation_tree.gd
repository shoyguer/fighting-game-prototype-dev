@tool
class_name AnimationStateMachine
extends AnimationTree


@export var action_animation: String
@export var walk_blend: String
@export var sprint_blend: String

var animations: Array[String] = []
var blend_weight: float = 0.2


func init(context: BaseCharacter) -> void:
	animations = context.animations


func set_movement_transition(action: String) -> void:
	set(action_animation, action)


func set_sprint_blend(move: Vector2, blend_weight_multiplier: float = 1.0):
	var move_original: float
	move_original = get(sprint_blend)
	
	var final_blend: float = blend_weight * blend_weight_multiplier
	move_original = lerp(move_original, move.x, final_blend)
	
	set(sprint_blend, move_original)


func set_walk_blend(move: Vector2, blend_weight_multiplier: float = 1.0) -> void:
	var move_original: Vector2
	
	move_original = get(walk_blend)
	
	var final_blend: float = blend_weight * blend_weight_multiplier
	move_original.x = lerp(move_original.x, move.x, final_blend)
	move_original.y = lerp(move_original.y, move.y, final_blend)
	
	set(walk_blend, move_original)
