class_name HitBox
extends Area3D
## Area for damaging enemies when a [BaseAttack] is happening.
## 
## This area will be responsible for damaging enemies.


@onready var collision: CollisionShape3D = $Collision


func disable_collision(type: bool) -> void:
	collision.disabled = type
