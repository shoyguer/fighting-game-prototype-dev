class_name BaseAttack
extends Resource


@export var animation_name: String
@export var damage: int
@export var animation_time: float = 1

@export_group("HitBox")
@export var hit_box_shape: BoxShape3D
@export var hit_box_position: Vector3 = Vector3(0.5, 1, 0)
