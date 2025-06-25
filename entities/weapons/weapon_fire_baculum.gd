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


func update_properties(
	new_cooldown: float,
	new_damage: float
) -> void:
	projectile_damage = new_damage
	cooldown_timer.wait_time = new_cooldown
	#cooldown_timer.start()
