class_name HurtBox
extends Area3D
## Area for receiving damage from an enemy [HitBox].
## 
## This area will be responsible for managing damage received from enemies.


var character: BaseCharacter = null

@onready var collision: CollisionShape3D = $Collision


func init(parent: BaseCharacter) -> void:
	character = parent


func disable_collision(type: bool) -> void:
	set_deferred("monitoring", type)


func receive_damage(_damage: int) -> void:
	pass


func _on_area_entered(area: Area3D) -> void:
	if (
		area is HitBox
		and area.character == character.enemy
		and not character.is_dead
	):
		
		spawn_hit_particle(area)
		
		character.cur_health_points -= area.attack.damage
		if character.cur_health_points > 0:
			character.state_manager.change_state(character.hurt_state)
		else:
			character.state_manager.change_state(character.death_state)
		
		disable_collision(false)
		await get_tree().create_timer(0.5).timeout
		disable_collision(true)


func spawn_hit_particle(area: Area3D) -> void:
	var impact_particle: CPUParticles3D = character.impact_particle.instantiate()
	character.add_child(impact_particle)
	
	var midpoint: Vector3 = (area.global_transform.origin + global_transform.origin) / 2
	midpoint.x = (2 * global_transform.origin.x + area.global_transform.origin.x) / 3
	impact_particle.global_transform.origin = midpoint
	impact_particle.global_position.y += 1.33
	
	var blood_particle: CPUParticles3D = character.blood_particles.instantiate()
	character.add_child(blood_particle)
	
	blood_particle.global_transform.origin = midpoint
	blood_particle.global_position.y += 1.33
	
	blood_particle.emitting = true
	impact_particle.emitting = true
