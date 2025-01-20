@tool
class_name BaseCharacter
extends CharacterBody3D


#region Variable Declaration
signal health_changed(character: BaseCharacter)

enum {
	RIGHT,
	LEFT
}

## For setting the current direction of the character
@export_group("Character")
@export var character_data: CharacterData
@export var max_health_points: int = 1000
@export var cur_health_points: int = 1000:
	set(value):
		cur_health_points = value
		cur_health_points = clampi(cur_health_points, 0, max_health_points)
		
		health_changed.emit(self)
	get:
		return cur_health_points
@export var turn_time: float = 0.66
@export var direction: int = RIGHT:
	set(value):
		direction = value
		direction = clampi(direction, 0, 1)
		
		if is_node_ready() and not is_dead:
			match direction:
				RIGHT:
					var tween = create_tween()
					#tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
					tween.tween_property(self, "rotation_degrees:y", 0, turn_time)
				
				LEFT:
					var tween = create_tween()
					#tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CIRC)
					tween.tween_property(self, "rotation_degrees:y", 180, turn_time)
	
	get:
		return direction
@export var health_bar: TextureProgressBar
@export var is_player: bool = false
@export var enemy: BaseCharacter

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

var move_speed: float = 5
var sprint_speed: float = 10
var crouch_speed: float = 2
var jump_velocity: float = 12
var is_punching: bool = false
var is_kicking: bool = false
var is_hit: bool = false
var is_dead: bool = false

@onready var mesh_root: Node3D = %MeshRoot
@onready var collision: CollisionShape3D = %Collision
@onready var move_component: MoveComponent = %MoveComponent
@onready var state_manager: StateManager = %StateManager
@onready var animation_tree: AnimationStateMachine = %AnimationTree

@onready var hurt_box: HurtBox = %HurtBox
@onready var hit_box: HitBox = %HitBox
#endregion


func _ready() -> void:
	# If not in editor, state manager and move component will be initialized
	if not Engine.is_editor_hint():
		hit_box.init(self)
		hurt_box.init(self)
	
		character_data.character_name = "Fighter"
	
		direction = direction
		
		state_manager.init(self)
		move_component.init(self)


func _process(_delta: float) -> void:
	if cur_health_points <= 0:
		is_dead = true


func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		state_manager.physics_process(delta)
		
		if global_position.z != 0:
			global_position.z = 0
		
		if direction == RIGHT:
			if enemy.global_position < global_position:
				direction = LEFT
		
		if direction == LEFT:
			if enemy.global_position > global_position:
				direction = RIGHT


func _input(event: InputEvent) -> void:
	if (
		not Engine.is_editor_hint()
		and is_player
	):
		state_manager.input(event)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if "Punch_0" in anim_name:
		is_punching = false
	if "Kick" in anim_name:
		is_kicking = false
	if "Hit" in anim_name:
		is_hit = false


func set_hit_box(attack: BaseAttack) -> void:
	hit_box.set_collision(attack)


func disable_hit_box(type: bool) -> void:
	hit_box.disable_collision(type)
