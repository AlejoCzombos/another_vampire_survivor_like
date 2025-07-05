extends ProjectilBase

func try_deal_damage(entity: Node2D) -> void:
	if entity.has_method("take_damage"):
		entity.take_damage(damage, true)
	queue_free()
