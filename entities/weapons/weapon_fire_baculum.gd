extends WeaponBase

func _process(_delta: float) -> void:
	if (current_state == STATE.SHOOTING):
		var nearest_enemy: EnemyBase = get_nearest_enemy()
		
		shoot(
			get_angle_to(nearest_enemy.global_position)
			if nearest_enemy
			else global_rotation
		)


func get_nearest_enemy() -> EnemyBase:
	var near_bodies: Array[Node2D] = self.get_overlapping_bodies()
	if near_bodies:
		return near_bodies.front()
	return null
