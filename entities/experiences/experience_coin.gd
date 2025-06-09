class_name ExperienceCoin
extends Node2D

func attract_to_player(position: Vector2) -> void:
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
	tween.tween_property(self, 'global_position', position, .5)
	tween.tween_callback(emit_experience_collected)
	tween.tween_callback(queue_free)

func emit_experience_collected() -> void:
	Events.experience_collected.emit()
