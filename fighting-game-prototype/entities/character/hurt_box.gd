class_name HurtBox
extends Area3D
## Area for receiving damage from an enemy [HitBox].
## 
## This area will be responsible for managing damage received from enemies.


@onready var collision: CollisionShape3D = $Collision


func disable_collision(type: bool) -> void:
	collision.disabled = type


# TODO: Variable declaration and functions.
func receive_damage(_damage: int) -> void:
	pass
