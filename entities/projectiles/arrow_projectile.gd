extends ProjectilBase

func try_deal_damage(entity: Node2D) -> void:
	if entity.has_method("take_damage"):
		var is_critic: bool = PlayerProperties.is_critic_damage()
		var projectil_damage: float = damage * (PlayerProperties.crit_multiplier if is_critic else 1.0)
		entity.take_damage(projectil_damage, is_critic)
	queue_free()
