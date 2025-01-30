class_name HitBox
extends Area3D
## Area for damaging enemies when a [BaseAttack] is happening.
## 
## This area will be responsible for damaging enemies.


var character: BaseCharacter = null
var attack: BaseAttack = null

@onready var collision: CollisionShape3D = $Collision


func init(parent: BaseCharacter) -> void:
	character = parent


func set_collision(current_attack: BaseAttack) -> void:
	attack = current_attack
	collision.shape = attack.hit_box_shape
	collision.position = attack.hit_box_position


func disable_collision(type: bool) -> void:
	collision.disabled = type


func _on_area_entered(area: Area3D) -> void:
	if area.character != character:
		AudioManager.play_sfx(attack.hit_sound)
