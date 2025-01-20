class_name HurtBox
extends Area3D
## Area for receiving damage from an enemy [HitBox].
## 
## This area will be responsible for managing damage received from enemies.


var character: BaseCharacter = null
var hit_state: BaseState = null
var death_state: BaseState = null

@onready var collision: CollisionShape3D = $Collision


func init(parent: BaseCharacter) -> void:
	character = parent
	hit_state = character.hit_state
	death_state = character.death_state


func disable_collision(type: bool) -> void:
	set_deferred("monitoring", type)


func receive_damage(_damage: int) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	if (
		area is HitBox
		and area.character == character.enemy
	):
		character.cur_health_points -= area.attack.damage
		if character.cur_health_points > 0:
			character.state_manager.change_state(hit_state)
		else:
			character.state_manager.change_state(death_state)
		
		disable_collision(false)
		await get_tree().create_timer(0.5).timeout
		disable_collision(true)
