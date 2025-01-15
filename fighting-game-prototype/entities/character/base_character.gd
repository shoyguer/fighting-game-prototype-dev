class_name BaseCharacter
extends CharacterBody3D

signal health_changes



@onready var animation_tree: AnimationStateMachine = %AnimationTree

## For setting the current direction of the character
@export_group("Character")
@export var character_data: CharacterData
@export var max_health_points: int = 1000
@export var cur_health_points: int = 1000:
	set(value):
		cur_health_points = value
		cur_health_points = clampi(cur_health_points, 0, max_health_points)
	get:
		return cur_health_points
@export var direction: Direction = Direction.RIGHT:
	set(value):
		direction = value
	get:
		return direction
@export var health_bar: TextureProgressBar

@export_group("States")
@export var jump_state: BaseState
@export var idle_state: BaseState
@export var crouch_state: BaseState
@export var walk_state: BaseState
@export var sprint_state: BaseState
@export var punch_state: BaseState
@export var kick_state: BaseState
@export var hit_state: BaseState
@export var death_state: BaseState
@export var starting_state: BaseState

enum Direction {
	LEFT = -1, RIGHT = 1
}

var move_speed: float = 5
var sprint_speed: float = 10
var crouch_speed: float = 2
var jump_velocity: float = 10
# Is it a real player or is it being controlled by AI?
var is_player: bool = false

var is_punching: bool = false
var is_kicking: bool = false
var is_hit: bool = false
var is_dead: bool = false

@onready var mesh: MeshInstance3D = %Mesh
@onready var mesh_root: Node3D = %MeshRoot
@onready var collision: CollisionShape3D = %Collision
@onready var move_component: MoveComponent = %MoveComponent
@onready var state_manager: StateManager = %StateManager


func _ready() -> void:
	character_data.character_name = "Fighter"
	
	direction = direction
	character_resource()
	# If not in editor, state manager and move component will be initialized
	if not Engine.is_editor_hint():
		state_manager.init(self)
		move_component.init(self)


func _process(delta: float) -> void:
	if cur_health_points <= 0:
		is_dead = true
	


func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		state_manager.physics_process(delta)
	


func _input(event: InputEvent) -> void:
	if not Engine.is_editor_hint():
		state_manager.input(event)
	
	


func character_resource() -> void:
	pass


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "Punch_0" in anim_name:
		is_punching = false
	if "Kick" in anim_name:
		is_kicking = false
	if "Hit" in anim_name:
		is_hit = false
