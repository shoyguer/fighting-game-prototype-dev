@tool
class_name BaseCharacter
extends CharacterBody2D


enum Direction {
	LEFT = -1, RIGHT = 1
}

@export var starting_state: BaseState
@export var direction: Direction = Direction.RIGHT:
	set(value):
		direction = value
		
		if animation_tree is AnimationStateMachine:
			animation_tree.animation_blend_all(direction)
	get:
		return direction
@export var collision: Rect2 = Rect2(0, 0, 20, 74):
	set(value):
		collision = value
		
		if collision_capsule is CollisionShape2D:
			collision_capsule.shape.radius = collision.size.x
			collision_capsule.shape.height = collision.size.y
			collision_capsule.position = collision.position
	get:
		return collision
@export var interaction: Rect2 = Rect2(0, 0, 26, 70):
	set(value):
		interaction = value
		
		if interaction_collision is CollisionShape2D:
			interaction_collision.shape.radius = interaction.size.x
			interaction_collision.shape.height = interaction.size.y
			interaction_collision.position = interaction.position
	get:
		return interaction

var speed = 125.0
var animations: Array[String] = []

# Animation nodes
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animation_tree: AnimationStateMachine = $AnimationTree
# State nodes
@onready var state_manager: StateManager = $StateManager
@onready var move_component: MoveComponent = $MoveComponent
# Collision nodes
@onready var interaction_area: Area2D = %InteractionArea
@onready var interaction_collision: CollisionShape2D = %InteractionCollision
@onready var collision_capsule: CollisionShape2D = %CollisionCapsule


func _ready() -> void:
	direction = direction
	
	# Sets the animations Array, will be used by the Animation Tree
	var this_script: GDScript = get_script()
	for property in this_script.get_script_property_list():
		if property.class_name == &"BaseState" and property.name != "starting_state":
			var state_name: String = property.name.trim_suffix("_state")
			state_name = state_name.to_pascal_case()
			animations.append(state_name)
	
	animation_tree.init(self)
	
	if not Engine.is_editor_hint():
		state_manager.init(self)
		move_component.init(self)


func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		state_manager.physics_process(delta)
