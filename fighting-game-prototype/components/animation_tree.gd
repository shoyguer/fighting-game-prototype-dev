@tool
class_name AnimationStateMachine
extends AnimationTree

@export var action_animation: String
var animations: Array[String] = []
@export var locomotion: String

func init(context: BaseCharacter) -> void:
	animations = context.animations


func animation_travel(animation_name: String) -> void:
	get("parameters/playback").travel(animation_name)


func animation_blend(animation_name: String, blend_position: float) -> void:
	set("parameters/" + animation_name + "/blend_position", blend_position)


func animation_blend_all(blend_position: float) -> void:
	for animation: String in animations:
		set("parameters/" + animation + "/blend_position", blend_position)


func set_movement_transition(action: String) -> void:
	set(action_animation, action)


func set_blend_position(move: Vector2) -> void:
	var move_original: Vector2 = get(locomotion)
	move_original.x = lerp(move_original.x, move.x, 0.1)
	move_original.y = lerp(move_original.y, move.y, 0.1)
	set(locomotion, move_original)
