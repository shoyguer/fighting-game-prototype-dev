@tool
class_name BaseRing
extends Node3D


@export_group("Characters")
@export var characters_distance: float = 4.0:
	set(value):
		characters_distance = value
		
		if (
			character_0 is CharacterBody3D
			and character_1 is CharacterBody3D
		):
			character_0.global_position.x = -characters_distance * 0.5
			character_1.global_position.x = characters_distance * 0.5
		
	get:
		return characters_distance

@export_group("Soundtrack")
@export_file("*.mp3") var soundtrack: String = ""

@export_group("Environment")
@export var wall_size: Vector3 = Vector3(1, 3, 5):
	set(value):
		wall_size = value
		
		if (
			wall_left is StaticBody3D
			and wall_right is StaticBody3D
		):
			# Wall Left
			wall_left_mesh.mesh.size = wall_size
			wall_left_collision.shape.size = wall_size
			
			# Wall Right
			wall_right_mesh.mesh.size = wall_size
			wall_right_collision.shape.size = wall_size
		
	get:
		return wall_size
@export var wall_left_position: Vector3 = Vector3(-15.5, 0, 0):
	set(value):
		wall_left_position = value
		
		if wall_left is StaticBody3D:
			wall_left.global_position = wall_left_position
		
	get:
		return wall_left_position
@export var wall_right_position: Vector3 = Vector3(15.5, 0, 0):
	set(value):
		wall_right_position = value
		
		if wall_right is StaticBody3D:
			wall_right.global_position = wall_right_position
		
	get:
		return wall_right_position

var paused: bool = false

# UI references
@onready var pause_menu_HUD: Control = $PauseMenu

# Character references
@onready var characters: Node3D = %Characters
@onready var character_0: BaseCharacter = %Character0
@onready var character_1: BaseCharacter = %Character1

# Environment Reference
# Wall Left
@onready var wall_left: StaticBody3D = %WallLeft
@onready var wall_left_mesh: MeshInstance3D = %WallLeftMesh
@onready var wall_left_collision: CollisionShape3D = %WallLeftCollision

# Wall Right
@onready var wall_right: StaticBody3D = %WallRight
@onready var wall_right_mesh: MeshInstance3D = %WallRightMesh
@onready var wall_right_collision: CollisionShape3D = %WallRightCollision

@onready var camera: Camera3D = %Camera
@onready var sounds: Node = %Sounds


func _ready() -> void:
	characters_distance = characters_distance
	
	wall_size = wall_size
	wall_left_position = wall_left_position
	wall_right_position = wall_right_position
	
	if not Engine.is_editor_hint():
		pause_menu_HUD.init(self)
		
		AudioManager.play_soundtrack(soundtrack, -30, sounds)


func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		if Input.is_action_just_pressed("pause"):
			pause_menu()
		
		camera.global_position.x = character_0.global_position.x


func pause_menu() -> void:
	if paused:
		pause_menu_HUD.hide()
		Global.pause_game(false)
	else:
		pause_menu_HUD.show()
		Global.pause_game(true)
	paused = !paused
