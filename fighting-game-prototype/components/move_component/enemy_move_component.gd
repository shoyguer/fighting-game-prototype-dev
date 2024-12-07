class_name EnemyMoveComponent
extends MoveComponent


# When a wall is touched, move in the opposite direction
func get_movement_direction() -> float:
	if parent.is_on_wall() == true:
		direction *= -1
	
	return direction

# Enemy can't jump
func wants_jump() -> bool:
	return false
