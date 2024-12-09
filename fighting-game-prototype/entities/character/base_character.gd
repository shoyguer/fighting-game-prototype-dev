class_name BaseCharacter
extends CharacterBody3D


## For setting the current direction of the character
enum Direction {
	LEFT = -1, RIGHT = 1
}
@export var jump_state: BaseState
@export var idle_state: BaseState
@export var crouch_state: BaseState
@export var walk_state: BaseState
@export var sprint_state: BaseState
@export var starting_state: BaseState
@export var direction: Direction = Direction.RIGHT:
	set(value):
		direction = value
		
		#if animation_tree is AnimationStateMachine:
			#animation_tree.animation_blend_all(direction)
	get:
		return direction

var move_speed: float = 5
var sprint_speed: float = 10
var crouch_speed: float = 2
var jump_velocity: float = 10
# Is it a real player or is it being controlled by AI?
var is_player: bool = false

@onready var mesh: MeshInstance3D = %Mesh
@onready var collision: CollisionShape3D = %Collision
@onready var move_component: MoveComponent = %MoveComponent
@onready var state_manager: StateManager = %StateManager


func _ready() -> void:
	direction = direction
	
	# If not in editor, state manager and move component will be initialized
	if not Engine.is_editor_hint():
		state_manager.init(self)
		move_component.init(self)


func _physics_process(delta: float) -> void:
	# If not in editor, state manager will play
	if not Engine.is_editor_hint():
		state_manager.physics_process(delta)


func _input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		state_manager.input(event)
