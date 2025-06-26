class_name ExperienceCoin
extends Node2D

# Function more performatic
#func attract_to_player(pos: Vector2) -> void:
	#var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_IN)
	#tween.tween_property(self, 'global_position', pos, .5)
	#tween.tween_callback(emit_experience_collected)
	#tween.tween_callback(queue_free)

func emit_experience_collected() -> void:
	Events.on_experience_collected.emit()

var is_following_player: bool = false
var target_player_position: Vector2

func attract_to_player(_unused: Vector2) -> void:
	is_following_player = true

func _process(delta: float) -> void:
	if is_following_player:
		var player_pos: Vector2 = Globals.get_player().global_position
		global_position = global_position.lerp(player_pos, delta * 8.0) # Ajustá velocidad
		if global_position.distance_to(player_pos) < 8.0:
			is_following_player = false
			collect_coin()

func collect_coin() -> void:
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, 'scale', Vector2.ZERO, 0.1)
	tween.tween_callback(emit_experience_collected)
	tween.tween_callback(queue_free)
