@tool
class_name AnimationStateMachine
extends AnimationTree


var animations: Array[String] = []


func init(context: BaseCharacter) -> void:
	animations = context.animations


func animation_travel(animation_name: String) -> void:
	get("parameters/playback").travel(animation_name)


func animation_blend(animation_name: String, blend_position: float) -> void:
	set("parameters/" + animation_name + "/blend_position", blend_position)


func animation_blend_all(blend_position: float) -> void:
	for animation: String in animations:
		set("parameters/" + animation + "/blend_position", blend_position)
